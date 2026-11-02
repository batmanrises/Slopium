# Releasing a new version

Slopium's updates reach TVs through the **Homebrew Channel**. Users add the repository once:

```
https://raw.githubusercontent.com/batmanrises/slopium/main/repo/apps.json
```

`repo/apps.json` never has to change. It points at `releases/latest/download/io.github.batmanrises.slopium.manifest.json`, so publishing a new GitHub release is all it takes for the Homebrew Channel to offer the update.

## Publish a release

1. Make your changes and test them on a TV.
2. Raise `"version"` in `app/appinfo.json` (for example `1.0.0` to `1.0.1`) and add a short entry to `CHANGELOG.md`. A new version must be **higher** than the one on the TV, or it will not be offered as an update.
3. Commit and push to `main`.
4. Tag and push the tag. The tag must be `v` plus the version:

   ```sh
   git tag v1.0.1
   git push origin v1.0.1
   ```
5. Optional: write the release description as `docs/release-notes/v<version>.md` (copy the previous one and edit it). The workflow uses it as the release text if it exists.
6. The **Release** workflow (`.github/workflows/release.yml`) checks that the tag matches the version, builds `io.github.batmanrises.slopium_<version>_all.ipk`, writes the manifest with its size and SHA-256, and publishes both on the Releases page.
7. On the TV, open the Homebrew Channel; Slopium shows an **Update** button.

## Doing it by hand

```sh
./tools/build-ipk.sh
./tools/make-manifest.sh
```

Then create a release on GitHub and attach both files from `build/`. The manifest and the `.ipk` must come from the same build, because the manifest records the exact size and hash.

## First-time GitHub setup

- Create the repository `batmanrises/slopium` (public, not a fork) and push this folder to it.
- In the repository's **Settings, Actions, General**, make sure Actions are allowed. The workflow only needs the default `contents: write` permission that it declares itself.
- Keep the file name `repo/apps.json` and the `main` branch name, because users' TVs have that address saved.

## Optional: the official webosbrew repository

Slopium can also be listed in the central repository at <https://repo.webosbrew.org> by opening a pull request to [webosbrew/apps-repo](https://github.com/webosbrew/apps-repo) with one `.yml` file that points at the same manifest. Read their rules first (they test the app; open source goes in the `main` pool). This is not needed for the custom repository above to work.
