# Taylor's Skill Collection

Hi, I'm Taylor. Welcome to my skill collection.

People keep asking me which skills I use, so I decided to show them here
instead of answering one message at a time.

You will find two things on this page: the skills I use from other people, and
the skills I created myself. I use many of them every day. For each one I tell
you who made it, what I find it helpful for, and how to install it, so you can
try it too.

If skills are new to you: a skill is a folder of instructions that an AI
coding tool such as [Claude Code](https://claude.com/claude-code) or Codex
picks up when a task matches. You teach the tool how you want a job done
once, instead of listing the same five or ten steps every time.

I grouped the skills by category, and every one is marked as one of two kinds:

- **Mine.** Skills I wrote. They live right here, in the [skills](skills)
  folder.
- **By someone else.** Skills other people wrote that I like and use. I do not
  copy their work into this repository. I link to the author's own repository,
  so you always get their latest version and they get the credit they deserve.

## Contents

- [Why this exists](#why-this-exists)
- [Before you start](#before-you-start)
- [Skills by category](#skills-by-category)
- [Resources](#resources)
- [Have a skill I should try](#have-a-skill-i-should-try)
- [Contributing](#contributing)
- [Contributors](#contributors)
- [More open-source projects](#more-open-source-projects)
- [License](#license)

## Why this exists

It started with a question I get a lot: "What skills do you use?" I never had
a good place to point people, so I made one.

It is also where my own skills live. I wrote my first one after setting up
[claude-watch](https://github.com/taylorarndt/claude-watch) by hand, one
request at a time. Instead of telling my agents "do these five or ten things"
every time I make a new project, I wrote those things down once as a skill.
Now the next project comes out the same without me repeating myself.

Most of what I use was made by other people, though, and I want to be clear
about that. Good skills take real work. This page is my way of sharing what
works for me and sending you to the people who built it.

## Before you start

A few things that will save you some trouble, whichever skill you pick:

- **Where skills go.** Claude Code reads skills from `~/.claude/skills`. Codex
  reads them from `~/.codex/skills`. Each skill is one folder with a
  `SKILL.md` file inside it.
- **Start a new session after installing.** The tool finds new skills when a
  session starts.
- **Commands that begin with `npx` need Node.** If you see
  `npx: command not found`, install Node with `brew install node`. If `brew` is
  not found either, install [Homebrew](https://brew.sh) first.

The `npx skills add` command asks which tools to install for and whether to
install for one project or all of them. Pick Claude Code, Codex, or both.

Commands that begin with `/plugin` are typed inside Claude Code, not in the
terminal.

## Skills by category

### Open source and GitHub

#### opensource-project-init

**Mine.** This is how I take a folder of working code and turn it into an
open-source repository on GitHub, start to finish. I used it to set up this
very repository. It covers:

- A secrets scan and a `.gitignore` before anything is pushed
- A private repository first, made public only on request
- A README with the origin story and honest notes on what has not been tested
- Issue forms in YAML, which a screen reader can move through field by field,
  and a pull request template
- Security, contributing, code of conduct, and support policies
- The MIT license
- Continuous integration with GitHub Actions, only where it checks something
  that was not tested by hand
- Topics, private vulnerability reporting, and a tagged release

I am blind and use a screen reader, and the skill is written around that: no
emoji or decorative characters, real alt text on every image, and plain
sentences that make sense read aloud.

Get the repository:

```
git clone https://github.com/taylorarndt/taylors-skill-collection.git
```

Install for Claude Code:

```
cp -R taylors-skill-collection/skills/opensource-project-init ~/.claude/skills/
```

Install for Codex:

```
cp -R taylors-skill-collection/skills/opensource-project-init ~/.codex/skills/
```

A heads up: I wrote this skill for myself, so it names me, my GitHub account,
and my choices throughout. Read
[SKILL.md](skills/opensource-project-init/SKILL.md) and change those to yours
before you rely on it. The templates it copies from are in
[skills/opensource-project-init/assets](skills/opensource-project-init/assets).

### SwiftUI

#### SwiftUI Pro

By Paul Hudson.
[SwiftUI-Agent-Skill](https://github.com/twostraws/SwiftUI-Agent-Skill).
Guidance for writing SwiftUI.

Install for Claude Code or Codex:

```
npx skills add https://github.com/twostraws/swiftui-agent-skill --skill swiftui-pro
```

### Swift concurrency

#### Swift Concurrency Pro

By Paul Hudson.
[Swift-Concurrency-Agent-Skill](https://github.com/twostraws/Swift-Concurrency-Agent-Skill).
Guidance for writing Swift concurrency code.

Install for Claude Code, typed inside Claude Code:

```
/plugin marketplace add twostraws/Swift-Concurrency-Agent-Skill
/plugin install swift-concurrency-pro@swift-concurrency-agent-skill
```

Install for Codex:

```
npx skills add https://github.com/twostraws/swift-concurrency-agent-skill --skill swift-concurrency-pro
```

### SwiftData

#### SwiftData Pro

By Paul Hudson.
[SwiftData-Agent-Skill](https://github.com/twostraws/SwiftData-Agent-Skill).
Guidance for working with SwiftData.

Install for Claude Code or Codex:

```
npx skills add https://github.com/twostraws/swiftdata-agent-skill --skill swiftdata-pro
```

### Testing

#### Swift Testing Pro

By Paul Hudson.
[Swift-Testing-Agent-Skill](https://github.com/twostraws/Swift-Testing-Agent-Skill).
Guidance for writing tests with Swift Testing.

Install for Claude Code, typed inside Claude Code:

```
/plugin marketplace add twostraws/Swift-Testing-Agent-Skill
/plugin install swift-testing-pro@swift-testing-agent-skill
```

Install for Codex:

```
npx skills add https://github.com/twostraws/swift-testing-agent-skill --skill swift-testing-pro
```

### From Apple, built into Xcode

#### Xcode's own skills

By Apple. Xcode 27 ships with skills written by Apple. They are not in a
repository. They are inside Xcode, and one command copies them out as ordinary
skill folders. You need Xcode 27 installed and selected with `xcode-select`.

Install for Claude Code:

```
xcrun agent skills export --output-dir ~/.claude/skills
```

Install for Codex:

```
xcrun agent skills export --output-dir ~/.codex/skills
```

After an Xcode update, run the same command again with `--replace-existing`
added to the end, so the newer versions overwrite the old ones:

```
xcrun agent skills export --output-dir ~/.claude/skills --replace-existing
```

With Xcode 27.0 the export gives ten skills:

- `swiftui-specialist`: SwiftUI best practices and performance
- `swiftui-whats-new-27`: SwiftUI changes in the 2027 system releases
- `building-document-based-swiftui-applications`: document-based apps in
  SwiftUI
- `app-intents-specialist`: App Intents best practices
- `app-intents-whats-new-27`: App Intents changes in iOS 26 and iOS 27
- `uikit-app-modernization`: moving UIKit apps to multi-window friendly APIs
- `modernize-tests`: moving from XCTest to Swift Testing
- `device-interaction`: checking an app on a device or simulator with
  screenshots, the interface hierarchy, and touches
- `adopt-c-bounds-safety`: the C bounds safety language extension
- `audit-xcode-security-settings`: turning on security-related build settings

These belong to Apple, so I do not copy them into this repository. Export them
from your own copy of Xcode.

### WWDC sessions

#### wwdc

By Superwall. [superwall/skills](https://github.com/superwall/skills). One
skill that lets the agent look up any WWDC session. It reads summaries from
[wwdc.ai](https://wwdc.ai), an unofficial site with a summary of every session.
The summaries are written by AI, not by Apple, so use them to find the right
session and check details against Apple's own video.

Install for Claude Code:

```
npx skills add https://github.com/superwall/skills --skill wwdc --global --agent claude-code universal
```

The command above is the one Superwall publishes, and it is for Claude Code.
For other tools, see the instructions in Superwall's repository.

### App Store Connect and releases

#### ASC CLI skills

By Rudrank Riyam and contributors.
[app-store-connect-cli-skills](https://github.com/rorkai/app-store-connect-cli-skills),
which now lives under the rorkai organization. Twenty-five skills for shipping
apps with the [asc command line tool](https://github.com/rorkai/App-Store-Connect-CLI):
builds, TestFlight, metadata and localization, screenshots, signing,
submissions, pricing, crash triage, and Apple Ads. It is a community project
and is not affiliated with Apple. The skills drive the `asc` tool, so install
that first, following the instructions in its repository.

Install for Claude Code, from the terminal:

```
claude plugin marketplace add rorkai/app-store-connect-cli-skills
claude plugin install asc@rorkai
```

Install for Codex:

```
npx skills add rorkai/app-store-connect-cli-skills --agent codex
```

If you already have `asc`, this also works:

```
asc install-skills
```

### In-app purchases

#### RevenueCat AI Toolkit

By RevenueCat. [RevenueCat/ai-toolkit](https://github.com/RevenueCat/ai-toolkit).
RevenueCat is a great way to handle payments inside apps: purchases,
subscriptions, and entitlements, without building the server side yourself.
Their toolkit gives the agent skills for adding RevenueCat to an app on iOS,
Android, Kotlin Multiplatform, Flutter, and React Native. It also connects the
agent to your RevenueCat account, so it can set up products, entitlements, and
offerings and read your revenue data.

Install for Claude Code, from the terminal:

```
claude plugins marketplace add RevenueCat/ai-toolkit
claude plugins install revenuecat
```

Install for Codex, from the terminal:

```
codex plugin marketplace add RevenueCat/ai-toolkit
```

Then start Codex, type `/plugins`, search for `revenuecat`, and install it. If
it shows as not logged in, run:

```
codex mcp login RevenueCat
```

Both tools ask you to sign in to your RevenueCat account in the browser the
first time. If you ship on Android, the same marketplace has a second plugin,
`revenuecat-play-billing`, with deeper guidance on Google Play billing.

## Resources

If you want to go further, these are the places I would send you to learn
about skills and find more of them:

- [claude-watch](https://github.com/taylorarndt/claude-watch). **Mine.** Not a
  skill, but a tool I made that tells you when a Claude Code session is waiting
  on you.
- [Swift-Agent-Skills](https://github.com/twostraws/Swift-Agent-Skills). By
  Paul Hudson. A curated directory of open-source skills for Swift and Apple
  platform development, from many authors.
- [skills.sh](https://skills.sh). A directory of skills that install with the
  `npx skills add` command used on this page.
- [Claude Code skills documentation](https://code.claude.com/docs/en/skills).
  How skills work in Claude Code and how to write your own.
- [Codex skills documentation](https://developers.openai.com/codex/skills). The
  same for Codex.
- [Agent Skills](https://agentskills.io). The open format that all of these
  skills follow, which is why one skill works in several tools.
- [wwdc.ai](https://wwdc.ai). Unofficial summaries of every WWDC session.
- [RevenueCat AI Toolkit documentation](https://www.revenuecat.com/docs/tools/ai-toolkit).
  RevenueCat's own guide to using their skills and tools with an agent.

## Have a skill I should try

I am always looking for good skills. If you made one, or you use one you think
I would like, please tell me about it. Open a
[Suggest a skill](https://github.com/taylorarndt/taylors-skill-collection/issues/new?template=suggest_a_skill.yml)
issue and say what it is, where it lives, and what it is helpful for.

I will try it. A skill only goes on this page after I have used it and kept
using it, because I want everything here to be something I can honestly vouch
for. If I add yours, you get the credit and the link goes to your repository.

Skills move and commands change, so if a link is broken or an install command
has stopped working, I would like to know. Open a
[Report a problem](https://github.com/taylorarndt/taylors-skill-collection/issues/new?template=report_a_problem.yml)
issue or send a pull request.

## Contributing

Suggestions, problem reports, and pull requests are welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md), the [Code of Conduct](CODE_OF_CONDUCT.md),
and [SUPPORT.md](SUPPORT.md). Report security problems privately as described
in [SECURITY.md](SECURITY.md).

## Contributors

<a href="https://github.com/taylorarndt/taylors-skill-collection/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=taylorarndt/taylors-skill-collection" alt="Profile pictures of the people who have contributed to Taylor's Skill Collection" />
</a>

Made with [contrib.rocks](https://contrib.rocks).

## More open-source projects

If you enjoyed this and want more open-source work, take a look at
[Community Access](https://github.com/Community-Access), an organization that
builds accessible, open-source software. Its website is
[community-access.org](https://community-access.org). A few of its projects:

- [accessibility-agents](https://github.com/Community-Access/accessibility-agents).
  Accessibility review agents for Claude Code, GitHub Copilot, and Claude
  Desktop, so AI coding tools stop producing inaccessible code.
- [quill](https://github.com/Community-Access/quill). A screen-reader-first
  writing and document environment for Windows.
- [git-going-with-github](https://github.com/Community-Access/git-going-with-github).
  An accessible workshop on Git, GitHub, and open source.

## License

My skills in this repository are under the [MIT license](LICENSE). Skills by
other people are covered by the license in their own repositories.
