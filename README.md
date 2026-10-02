# claude-skills

Skills I have written for [Claude Code](https://claude.com/claude-code). A
skill is a folder of instructions that Claude loads when a task matches, so it
does the job the way I want it done without being told again each time.

## Why this exists

I kept explaining the same steps to Claude every time I set up a project. After
setting up [claude-watch](https://github.com/taylorarndt/claude-watch) by hand,
one request at a time, I wrote the steps down as a skill so the next project
comes out the same. This repository is where those skills live, so other people
can read them, use them, and change them to fit how they work.

## Skills

### opensource-project-init

How I take a folder of working code and turn it into an open-source repository
on GitHub, start to finish:

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

## Using a skill

Copy the skill's folder into your Claude Code skills folder:

```
git clone https://github.com/taylorarndt/claude-skills.git
cp -R claude-skills/skills/opensource-project-init ~/.claude/skills/
```

Claude Code picks it up in the next session. The skill names me, my GitHub
account, and my choices throughout, so read `SKILL.md` and change those to
yours before you rely on it.
