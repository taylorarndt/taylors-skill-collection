# Security policy

## Supported versions

Only the latest version on the `main` branch is supported. Fixes are not
backported.

## Reporting a vulnerability

Please do not open a public issue for a security problem.

Report it privately through GitHub:
<https://github.com/taylorarndt/taylors-skill-collection/security/advisories/new>

Include what you found and how to reproduce it. You should get a reply within
7 days. If the report is confirmed, a fix will be released and you will be
credited unless you ask not to be.

## What this repository touches

Knowing this helps you judge what counts as a vulnerability:

- This repository holds no program of its own. It is a README, policy files,
  and skills, which are Markdown instructions and template files that an AI
  coding agent reads.
- A skill runs with the full permissions of the agent that loads it. My
  `opensource-project-init` skill tells the agent to run `git` and the GitHub
  command line tool `gh`: to create repositories, push commits, change a
  repository's visibility, set topics, and create releases on the account that
  is signed in.
- Nothing here stores data, starts a background job, or sends anything off the
  machine apart from those `git` and `gh` commands.
- The README gives install commands for skills by other people. Those commands
  download and install code and instructions from the author's repository.
  Read a skill before you install it.

In scope: anything in my own skills that could lead an agent to leak secrets,
publish something private, or run a harmful command, and any install command on
this page that points somewhere it should not. A problem inside a skill by
someone else belongs in that author's repository, but tell me too so I can
take the link down.
