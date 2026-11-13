# Source notes

## What this repository contains

Slopium is a modified build of [Hearth](https://github.com/rudra-avatar/Hearth). Hearth is written in TypeScript with Preact and compiled (with Vite) into one bundled script, `assets/app.js`. The Slopium changes were made directly on top of a compiled Hearth bundle, so this repository contains:

- `app/`: the installable webOS app exactly as it is packaged, including the single bundled, minified `app/assets/app.js`.
- `tools/build-ipk.sh`, `packaging/`: everything needed to package `app/` into an `.ipk`.
- `docs/`, `branding/`: screenshots and the logo.

It does **not** contain a separate, readable TypeScript source tree for Slopium's own changes.

## What that means

- Everything in `app/` is plain text and can be read and edited, but `app.js` is minified and hard to work on by hand.
- Hearth's own readable source is available under the MIT licence at <https://github.com/rudra-avatar/Hearth>. It is the best place to understand the parts of Slopium that come from Hearth.
- The parts that Slopium adds or changes (Recent apps panel, quiet-mode schedule and movement styles, the extra clock styles, thickness handling, shuffle memory, card tint position, the custom screen saver: its install script and its slideshow QML are plain-text strings named `hxSvScript` and `hxSvQml` inside `app.js`) live inside `app.js`. Contributors who want to work on them would need to port them into a normal source tree (for example a fork of Hearth's `src/`) and build from there.

Contributions that turn Slopium into a proper source build are very welcome.
