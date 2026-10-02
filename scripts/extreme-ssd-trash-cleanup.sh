#!/bin/bash
# Deletes the current user's Trash on /Volumes/Extreme SSD, then recreates
# that directory owned by this user (staff) with mode 700.
#
# Run it in Terminal. It calls sudo. This agent environment cannot sudo.
# If macOS says "Operation not permitted", give Terminal Full Disk Access
# (System Settings → Privacy & Security → Full Disk Access), restart Terminal,
# and run it again.
# After it succeeds, empty Trash in Finder with the drive connected.

set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "error: this script is for macOS only." >&2
  exit 1
fi

VOLUME="/Volumes/Extreme SSD"
TRASH_DIR="$VOLUME/.Trashes/$(id -u)"

if [[ ! -d "$VOLUME" ]]; then
  echo "error: ${VOLUME} is not mounted. Connect the drive and try again." >&2
  exit 1
fi

echo "Open files on ${VOLUME}:"
open_files="$(sudo lsof 2>/dev/null | grep "$VOLUME" || true)"
if [[ -n "$open_files" ]]; then
  printf '%s\n' "$open_files"
else
  echo "(none)"
fi

echo "Warning: this permanently deletes this volume's Trash for the current user (${TRASH_DIR})."

sudo rm -rf "$TRASH_DIR"
sudo mkdir "$TRASH_DIR"
sudo chown "$(id -u):staff" "$TRASH_DIR"
sudo chmod 700 "$TRASH_DIR"
sudo ls -la "$TRASH_DIR"
