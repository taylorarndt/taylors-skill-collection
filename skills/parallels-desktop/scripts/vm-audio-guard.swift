// vm-audio-guard: keeps sound working in a Parallels Windows VM when Bluetooth
// headphones switch between music mode and headset (microphone) mode.
//
// Parallels 27 on macOS 27 fails to start VM audio unless the Windows playback
// format suits the Mac output device: 48000 Hz in headset mode (16 kHz output),
// 88200 Hz in music mode (44.1 kHz output). This watches the Mac's output and the
// VM log, sets the matching format inside Windows, and reconnects the VM sound card.
import CoreAudio
import Foundation

let vmName = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "Windows 11"
let prlctl = "/usr/local/bin/prlctl"
let guestScript = "C:\\ProgramData\\VMAudioFix\\set-format.ps1"
let failureText = "failed starting of output audio device"
let logURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/Logs/vm-audio-guard.log")

func log(_ s: String) {
    let f = ISO8601DateFormatter(); f.timeZone = .current
    let line = "\(f.string(from: Date())) \(s)\n"
    if let h = try? FileHandle(forWritingTo: logURL) { h.seekToEndOfFile(); h.write(line.data(using: .utf8)!); try? h.close() }
    else { try? line.write(to: logURL, atomically: true, encoding: .utf8) }
}

@discardableResult func run(_ args: [String]) -> (Int32, String) {
    let p = Process(); p.executableURL = URL(fileURLWithPath: prlctl); p.arguments = args
    let pipe = Pipe(); p.standardOutput = pipe; p.standardError = pipe
    do { try p.run() } catch { return (-1, "\(error)") }
    let data = pipe.fileHandleForReading.readDataToEndOfFile(); p.waitUntilExit()
    return (p.terminationStatus, String(data: data, encoding: .utf8) ?? "")
}

func hostOutput() -> (name: String, rate: Int) {
    let sys = AudioObjectID(kAudioObjectSystemObject)
    var a = AudioObjectPropertyAddress(mSelector: kAudioHardwarePropertyDefaultOutputDevice, mScope: kAudioObjectPropertyScopeGlobal, mElement: kAudioObjectPropertyElementMain)
    var dev: AudioObjectID = 0; var sz = UInt32(4)
    AudioObjectGetPropertyData(sys, &a, 0, nil, &sz, &dev)
    a.mSelector = kAudioDevicePropertyNominalSampleRate
    var rate: Double = 0; sz = 8
    AudioObjectGetPropertyData(dev, &a, 0, nil, &sz, &rate)
    a.mSelector = kAudioObjectPropertyName
    var s: Unmanaged<CFString>? = nil; sz = UInt32(MemoryLayout<Unmanaged<CFString>?>.size)
    AudioObjectGetPropertyData(dev, &a, 0, nil, &sz, &s)
    return ((s?.takeRetainedValue() as String?) ?? "?", Int(rate))
}

// The Windows format that works for a given Mac output rate. nil means any format works.
func targetRate(forHost rate: Int) -> Int? {
    if rate > 0 && rate < 32000 { return 48000 }   // Bluetooth headset mode
    if rate == 44100 { return 88200 }              // Bluetooth music mode
    return nil                                     // built-in speakers and others
}

func vmLogPath() -> String {
    let (_, out) = run(["list", "-i", vmName])
    for line in out.split(separator: "\n") where line.hasPrefix("Home: ") {
        return String(line.dropFirst(6)).trimmingCharacters(in: .whitespaces) + "parallels.log"
    }
    return NSHomeDirectory() + "/Parallels/\(vmName).pvm/parallels.log"
}

func vmRunning() -> Bool { run(["status", vmName]).1.contains("running") }

func apply(_ rate: Int, reason: String) -> Bool {
    guard vmRunning() else { log("skip (\(reason)): VM not running"); return false }
    let (_, out) = run(["exec", vmName, "--current-user", "powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", guestScript, "-Rate", "\(rate)"])
    guard out.contains("hr=0x00000000") else {
        log("could not set \(rate) Hz (\(reason)): \(out.trimmingCharacters(in: .whitespacesAndNewlines).prefix(200))"); return false
    }
    run(["set", vmName, "--device-disconnect", "sound0"])
    Thread.sleep(forTimeInterval: 2)
    run(["set", vmName, "--device-connect", "sound0"])
    log("set Windows to \(rate) Hz and reconnected sound (\(reason))")
    return true
}

if CommandLine.arguments.contains("--once") {
    let h = hostOutput()
    let ok = apply(targetRate(forHost: h.rate) ?? 88200, reason: "manual run, output \(h.name) at \(h.rate) Hz")
    exit(ok ? 0 : 1)
}

let vmLog = vmLogPath()
var logOffset = (try? FileManager.default.attributesOfItem(atPath: vmLog)[.size] as? UInt64) ?? 0
var lastHost = hostOutput()
var lastApplied: Int? = nil
var settleAt: Date? = nil
var retryAt: Date? = nil
var ignoreFailuresUntil = Date()
var forcedTimes: [Date] = []
log("started for \"\(vmName)\", output \(lastHost.name) at \(lastHost.rate) Hz")

func newFailureInVMLog() -> Bool {
    guard let size = try? FileManager.default.attributesOfItem(atPath: vmLog)[.size] as? UInt64 else { return false }
    if size < logOffset { logOffset = 0 }   // log was rotated
    guard size > logOffset, let h = FileHandle(forReadingAtPath: vmLog) else { return false }
    defer { try? h.close() }
    h.seek(toFileOffset: logOffset)
    let data = h.readDataToEndOfFile(); logOffset = size
    return String(decoding: data, as: UTF8.self).contains(failureText)
}

while true {
    Thread.sleep(forTimeInterval: 2)
    let now = Date()
    let host = hostOutput()
    if host.rate != lastHost.rate || host.name != lastHost.name {
        lastHost = host; settleAt = now.addingTimeInterval(1.5)   // let the Bluetooth switch finish
    }
    let failed = newFailureInVMLog() && now > ignoreFailuresUntil
    var reason: String? = nil
    var rate: Int? = nil
    if let s = settleAt, now >= s {
        settleAt = nil
        if let t = targetRate(forHost: host.rate), t != lastApplied { rate = t; reason = "output changed to \(host.name) at \(host.rate) Hz" }
    } else if let r = retryAt, now >= r {
        retryAt = nil
        if let t = targetRate(forHost: host.rate), t != lastApplied { rate = t; reason = "retry" }
    } else if failed, settleAt == nil {
        // Sound failed with no output change: something reset the Windows format. Re-apply.
        forcedTimes = forcedTimes.filter { now.timeIntervalSince($0) < 300 }
        if forcedTimes.count < 3 {
            forcedTimes.append(now); rate = targetRate(forHost: host.rate) ?? 88200; reason = "VM sound failed to start"
        }
    }
    if let rate, let reason {
        if apply(rate, reason: reason) { lastApplied = rate } else { retryAt = Date().addingTimeInterval(20) }
        ignoreFailuresUntil = Date().addingTimeInterval(15)
        _ = newFailureInVMLog()   // skip lines written during the reconnect
    }
}
