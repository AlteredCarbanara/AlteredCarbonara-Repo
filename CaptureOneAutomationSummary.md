## Capture One Automation Discussions (Nov 30, 2025)

### Current Objective
- Explore how to automate Capture One cataloging workflows via AppleScript before writing any code.
- Confirm feasibility of features derived from the provided YouTube transcript: importing, folder structures, metadata, keywords, ratings, smart albums, and backups.

### Key Findings
- **Catalog creation** must still be done manually; the AppleScript suite can only open existing catalogs.
- **Import automation** is partially scriptable. True drag-and-drop workflows are UI-only, but scripts can prepare folders/files on disk then “add” them to catalogs.
- **Folder/date structures & renaming** can be handled outside Capture One (Finder or shell) before import; Capture One tokens are not exposed to AppleScript.
- **Metadata, keywords, ratings, color tags** are scriptable; hierarchical keywords (PAP method) can be created/applied programmatically.
- **Smart albums** can be scripted with the suite’s criteria dictionaries, though complex predicates may need manual setup.
- **Backup reminders & missing-file checks** are scriptable; actual catalog backup automation requires ensuring Capture One is closed and copying the `.cocatalog` package via shell commands.

### Draft Requirements Captured
1. Confirm catalog path and environment before automation runs.
2. Handle import sources (cards, staging folders) and copy assets into `YYYY/MM/DD/Event` structures automatically.
3. Rename files using a consistent template pre-import.
4. Apply IPTC metadata presets and maintain PAP keyword hierarchy mappings.
5. Set baseline ratings/color tags and auto-generate smart albums for common filters.
6. Provide reminders/utilities for catalog backups and relocation of missing files.
7. Store all defaults (paths, naming templates, metadata values) in a configuration file for repeatable runs.

### Next-Step Options (Not Yet Executed)
1. Inspect the current Capture One AppleScript dictionary to verify each required verb/property.
2. Prioritize which requirements to implement first and draft pseudo-code/flow.
3. Design the configuration schema and user prompts for the eventual script.

_Status: Planning phase only. No automation code has been written yet._

