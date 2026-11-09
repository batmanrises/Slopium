# Changelog

## 1.0.3: wallpaper slideshow fix

- **Fixed the USB slideshow only using part of a big folder.** Only the first 400 pictures (in name order) of a folder were ever loaded, so with more than 400 pictures the rest were never shown and the shuffle just repeated that same group. The limit is now 5,000 pictures per folder, and shuffle covers all of them.
- The saved shuffle order starts fresh after this update, so the first round after updating mixes in every picture instead of replaying the old 400 first.

## 1.0.2: icon fixes

- **Fixed app icons that did not convert properly to white marks** (Clean marks). Icons whose logo touches the edge of the icon, such as Moonfin, lost most of their shape. Icons with fine detail on a transparent background, such as Aurora, turned into a solid blob. They now convert to a complete mark. Icons converted earlier are redone automatically.

## 1.0.1: install fix

- **Fixed the "-5: Failed to extract package" install error** that some TVs showed with 1.0.0 (reported on webOS 5.5). The package is now built in the exact layout those TVs expect.
- Building the package no longer needs the `ar` tool, so it also works in Git Bash on Windows.

## 1.0.0: first public release as Slopium

> Version numbering starts again at 1.0.0 because Slopium is a new app with its own ID. The 2.x numbers belonged to earlier private builds under the old `tld.my.customlauncher` ID.

The launcher is renamed **Slopium** and published as its own open-source project. It is a modified version of [Hearth](https://github.com/rudra-avatar/Hearth) (MIT); see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

- New name, logo and app icon; all in-app mentions of the old name replaced.
- **Its own app ID, `io.github.batmanrises.slopium`**, so it installs next to Hearth instead of replacing it. Settings from older `tld.my.customlauncher` builds are not carried over.
- Everything that used a shared name is now unique to Slopium: stored settings, the "replace LG Home" helper files and their start-up link, log and marker files in `/tmp`, and the process patterns used to find and stop them.
- **Update path:** a Homebrew Channel repository (`repo/apps.json`) and a GitHub Actions workflow that publishes the `.ipk` and its manifest for every tagged release.
- New fresh-install defaults for Look, Icons, Clock, Weather, Wallpaper and Options (listed in the README).
- Added the licence, credits and disclaimer files (`LICENSE`, `THIRD_PARTY_NOTICES.md`, `DISCLAIMER.md`, `app/licenses/NOTICE.txt`) and a repository layout with build scripts.

### Changes made to the Hearth base before this release

- **Recent apps panel**: Back on the home screen opens a bottom panel of the apps in memory, with "Close all"; adjustable width and height. Closing responds on the first press: the cards leave the panel at once, the apps are stopped together, and the TV's recent list is cleaned up once they have quit.
- **Quiet mode**: fixed timetable (first move after 5 s, then every 20 s; wallpaper changes timed to never coincide); movement style choice (fade out and reappear, glide, jump, off); instant return with no row animation; reliable reset to the default state after the screensaver.
- **Clock**: 14 styles (new: Dot matrix, Nixie tubes, Calendar page, Sun arc, Day timeline; Pill and Neon glow folded into Frosted card and the Neon theme); thickness now applies to the whole clock, with Extra bold and Black steps.
- **Weather**: the "Today" icon now agrees with the current conditions.
- **Wallpaper**: shuffle remembers its order and place across restarts and no longer repeats the previous round's order.
- **Glass and themes**: the card tint is picked from the card's default position, not from where quiet mode has moved it.
- **Performance**: removed leftover code and animations that cost time on weak TV hardware.
