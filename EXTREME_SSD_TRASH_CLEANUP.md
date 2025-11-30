# Extreme SSD Trash Cleanup

Documenting how we resolved the “files in use” errors when emptying Trash with the `Extreme SSD` external drive attached.

## 1. Inspect the drive
- Verified the drive was mounted at `/Volumes/Extreme SSD`.
- Listed top-level contents to confirm access.

## 2. Identify the stuck trash entries
- Determined current user ID (`id -u` → `501`).
- Attempted to list `/Volumes/Extreme SSD/.Trashes/501` and saw `Operation not permitted`.
- Re-ran with `sudo` and saw orphaned folders owned by `_unknown` (e.g., `Thumbnails`, `Trash`).

## 3. Check for open file handles
- `sudo lsof | grep '/Volumes/Extreme SSD'` produced no output, confirming no processes were using the drive.

## 4. Clear the trash directory
- Direct removal with `sudo rm -rf '/Volumes/Extreme SSD/.Trashes/501/'*` failed in `zsh` because the glob didn’t match.
- Deleted the entire trash folder instead:
  - `sudo rm -rf '/Volumes/Extreme SSD/.Trashes/501'`
- Recreated it with proper ownership and permissions so Finder can reuse it:
  - `sudo mkdir '/Volumes/Extreme SSD/.Trashes/501'`
  - `sudo chown 501:staff '/Volumes/Extreme SSD/.Trashes/501'`
  - `sudo chmod 700 '/Volumes/Extreme SSD/.Trashes/501'`

## 5. Verify
- `sudo ls -la '/Volumes/Extreme SSD/.Trashes/501'` now shows only `.` and `..`.
- Emptying the Trash in Finder succeeds with the drive connected.

## Notes for next time
- If `sudo ls` still reports `Operation not permitted`, ensure Terminal has **Full Disk Access** in System Settings → Privacy & Security.
- When working in `zsh`, unmatched globs cause errors; deleting or quoting the entire directory path avoids that.

