# Clean up after yourself

Basic rules for AI coding agents, for every project and every session.

## If you start it, clean it up

Leave the computer the way you found it. Before you say a task is done, undo anything you started that the user didn't ask to keep:
- Apps you opened (Simulator, Xcode, a browser, a cleaner, a VM window): quit them, unless the user was already using them.
- Background work: dev servers, watchers, log captures, booted simulators, and background shell tasks. Stop them.
- Files: scratch scripts, screenshots, downloads, test copies, and temporary branches or worktrees. Delete them.
- Settings you changed only for a test: put them back.

If something has to keep running, say what it is, why, and how to stop it.

## Work in clear, normal places

- Don't work in `/private/tmp`, `/tmp`, `/private/var/folders`, or other hidden or obscure folders. Work left there is easy to forget and hard for the user to find.
- If a temp folder really is the right place, say why and exactly where before you use it, and remove it when you're done.
- Work in the project folder. For Xcode, use the default DerivedData. Other build output goes in a git-ignored `build/` folder inside the project.
- If something big gets downloaded or generated (a model, a dataset, an archive, a log capture), say where it went and how big it is, and remove it when it's no longer needed.
