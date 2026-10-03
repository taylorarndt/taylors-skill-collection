# Sets the default format of every active Windows playback device to 16-bit stereo at -Rate.
# Called from the Mac by vm-audio-guard. Works around the Parallels 27 / macOS 27 audio bug.
param([uint32]$Rate = 88200)
$src = @"
using System; using System.Runtime.InteropServices;
[StructLayout(LayoutKind.Sequential, Pack=2)] public struct WFX { public ushort tag, ch; public uint rate, avg; public ushort align, bits, cb, valid; public uint mask; public Guid sub; }
[ComImport, Guid("f8679f50-850a-41cf-9c72-430f290290c8"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
public interface IPolicyConfig { [PreserveSig] int GetMixFormat(string id, out IntPtr f); [PreserveSig] int GetDeviceFormat(string id, int def, out IntPtr f); [PreserveSig] int ResetDeviceFormat(string id); [PreserveSig] int SetDeviceFormat(string id, ref WFX e, ref WFX m); }
[ComImport, Guid("870af99c-171d-4f9e-af0d-e63df40c2bc9")] public class PolicyConfigClient {}
public static class Fmt { public static int Set(string id, uint r) { var w = new WFX { tag=0xFFFE, ch=2, rate=r, avg=r*4, align=4, bits=16, cb=22, valid=16, mask=3, sub=new Guid("00000001-0000-0010-8000-00aa00389b71") }; return ((IPolicyConfig)new PolicyConfigClient()).SetDeviceFormat(id, ref w, ref w); } }
"@
Add-Type -TypeDefinition $src
$root = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render'
Get-ChildItem $root | Where-Object { (Get-ItemProperty $_.PSPath).DeviceState -eq 1 } | ForEach-Object {
  $hr = [Fmt]::Set('{0.0.0.00000000}.' + $_.PSChildName, $Rate)
  $line = "{0} {1} rate={2} hr=0x{3:X8}" -f (Get-Date -Format s), $_.PSChildName, $Rate, $hr
  Add-Content "$env:ProgramData\VMAudioFix\log.txt" $line
  $line }
