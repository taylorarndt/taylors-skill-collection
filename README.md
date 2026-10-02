# claude-skills

Welcome to my skill collection.

A skill is a folder of instructions that an AI coding tool such as
[Claude Code](https://claude.com/claude-code) loads when a task matches, so it
does the job a particular way without being told again each time.

This page lists the skills I use, grouped by category. There are two kinds:

- **Mine.** Skills I wrote. They live in this repository, in the
  [skills](skills) folder.
- **By someone else.** Skills other people wrote that I like and use. I do not
  copy them here. I link to the author's own repository, so you get their
  latest version and they get the credit. Go to their repository to read the
  skill, install it, and check its license.

Every entry says who made it.

## Why this exists

I kept explaining the same steps to Claude every time I set up a project. After
setting up [claude-watch](https://github.com/taylorarndt/claude-watch) by hand,
one request at a time, I wrote the steps down as a skill so the next project
comes out the same. This repository is where my skills live, next to links to
the skills from other people that I rely on, so it is all in one place.

## Skills by category

### Open source and GitHub

- [opensource-project-init](skills/opensource-project-init). **Mine.** How I
  take a folder of working code and turn it into an open-source repository on
  GitHub, start to finish. More detail is under
  [My skills](#my-skills) below.

### SwiftUI

- [SwiftUI-Agent-Skill](https://github.com/twostraws/SwiftUI-Agent-Skill).
  By Paul Hudson. Guidance for writing SwiftUI.

### Swift concurrency

- [Swift-Concurrency-Agent-Skill](https://github.com/twostraws/Swift-Concurrency-Agent-Skill).
  By Paul Hudson. Guidance for writing Swift concurrency code.

### SwiftData

- [SwiftData-Agent-Skill](https://github.com/twostraws/SwiftData-Agent-Skill).
  By Paul Hudson. Guidance for working with SwiftData.

### Testing

- [Swift-Testing-Agent-Skill](https://github.com/twostraws/Swift-Testing-Agent-Skill).
  By Paul Hudson. Guidance for writing tests with Swift Testing.

### Finding more skills

- [Swift-Agent-Skills](https://github.com/twostraws/Swift-Agent-Skills).
  By Paul Hudson. A curated directory of open-source skills for Swift and Apple
  platform development, from many authors.

## My skills

### opensource-project-init

It covers:

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

The templates it copies from are in
[skills/opensource-project-init/assets](skills/opensource-project-init/assets).

I am blind and use a screen reader, and the skill is written around that: no
emoji or decorative characters, real alt text on every image, and plain
sentences that make sense read aloud.

## Using one of my skills

Copy the skill's folder into your Claude Code skills folder:

```
git clone https://github.com/taylorarndt/claude-skills.git
cp -R claude-skills/skills/opensource-project-init ~/.claude/skills/
```

Claude Code picks it up in the next session. The skill names me, my GitHub
account, and my choices throughout, so read `SKILL.md` and change those to
yours before you rely on it.

For a skill by someone else, follow the install steps in that author's
repository.
