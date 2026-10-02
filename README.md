# macOS Troubleshooting Notes and Automation

A personal collection of notes and scripts from working on my own Mac. Each file documents a real problem I hit, what I checked, and what actually fixed it. When a fix was worth repeating, I turned it into a script.

## What's in here

| File | What it is |
| --- | --- |
| `EXTREME_SSD_TRASH_CLEANUP.md` | How I tracked down and fixed "files in use" errors when emptying the Trash with an external SSD attached. |
| `scripts/extreme-ssd-trash-cleanup.sh` | The same fix as a script, so it can be re-run instead of retyped. |
| `CaptureOneAutomationSummary.md` | Planning notes on automating Capture One cataloging with AppleScript. |

## Extreme SSD Trash Cleanup

Two files cover this one. `EXTREME_SSD_TRASH_CLEANUP.md` is the investigation: it walks through checking that the drive was mounted, finding orphaned folders owned by `_unknown` inside `/Volumes/Extreme SSD/.Trashes/501`, confirming with `lsof` that nothing actually had the files open, and then deleting and recreating the trash directory with the right owner and permissions. It also records the two things that tripped me up — `Operation not permitted` until Terminal had Full Disk Access, and a `zsh` glob that didn't match.

`scripts/extreme-ssd-trash-cleanup.sh` is the repeatable fix. The document explains why the steps work; the script just runs them, in order, every time. It checks that it's on macOS and that the drive is mounted before touching anything, lists any open files on the volume, deletes the current user's trash directory, recreates it owned by that user and the `staff` group with mode `700`, and prints the result so you can confirm it's empty.

The script finds the user id with `id -u` rather than hardcoding `501`, so run it as yourself:

```bash
chmod +x scripts/extreme-ssd-trash-cleanup.sh
./scripts/extreme-ssd-trash-cleanup.sh
```

It calls `sudo` on its own and will ask for your password. Don't put `sudo` in front of the script itself — `id -u` would then return root's id and the script would clear the wrong trash directory.

### Warning

This permanently deletes that volume's Trash for the current user. Nothing goes to a recovery folder and nothing can be restored from Finder afterwards. If there is anything in the external drive's Trash you still want, pull it out before running the script.

### Full Disk Access

If macOS reports `Operation not permitted`, Terminal needs Full Disk Access: **System Settings → Privacy & Security → Full Disk Access**. Add Terminal, quit it completely, reopen it, and run the script again.

Once the script finishes cleanly, empty the Trash in Finder with the drive still connected.

## Capture One Automation

`CaptureOneAutomationSummary.md` is the research stage of a different project: automating a Capture One photo cataloging workflow with AppleScript. It records what the AppleScript suite can and can't reach — catalogs still have to be created by hand, imports are only partly scriptable, but metadata, keywords, ratings, and smart albums are all reachable from a script — along with the requirements I'd want the eventual tool to meet and the next steps for verifying them.

It is deliberately a planning document. No automation code has been written yet, and the file says so.
