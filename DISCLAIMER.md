# Disclaimer and warnings

**Please read this before installing Slopium.**

## 1. Use at your own risk

Slopium is a free, personal / hobby project provided **"as is", without warranty of any kind**, express or implied. By installing or using it you accept all risk. To the maximum extent permitted by law, the authors and contributors are **not liable** for any damage, data loss, malfunction, loss of warranty, loss of service or any other harm to your TV, your other devices, your accounts or anything else, however it arises. This follows the MIT licence in [LICENSE](LICENSE).

## 2. Root privileges and your TV

Slopium works as an ordinary webOS app, but many of its features need a **rooted** TV with the [Homebrew Channel](https://github.com/webosbrew/webos-homebrew-channel). Rooting a TV and running software with root privileges:

- can **void your warranty**,
- can make the TV unstable or, in the worst case, stop it from working properly,
- may be restricted or unsupported by LG, and may stop working after a firmware update,
- is done entirely at your own risk and responsibility.

On a rooted TV, Slopium asks the Homebrew Channel's service to run a small set of fixed commands. In plain terms it can:

- list apps, launch apps, and **close** running apps (the Recent apps panel and "Close all");
- **uninstall** apps when you choose that from an app's menu;
- read picture files from USB drives and the TV's storage (wallpapers, custom icons);
- add itself as a TV input and read or change a few TV settings you switch on in Options;
- check which app is in front.

It does **not** contain advertising, analytics or telemetry. The only outside connections are to Open-Meteo for weather (see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)). If the TV's web view cannot make a secure connection, the weather fetch can fall back to the TV's own `curl`/`wget`, and the last-resort attempts skip the certificate check; this is only used for public weather numbers.

If you are not comfortable with any of this, do not install Slopium, or do not use the options that need root.

## 3. Personal use

Slopium is meant for personal use on a TV that **you own**. It is not a commercial product and comes with no support obligation.

## 4. Third-party content

- **Wallpapers, photographs, app icons, logos and brand marks** belong to their respective owners and are **not** covered by the MIT licence. They are included to make the launcher usable and to identify apps. If you are an owner and want something removed, open an issue.
- **Trademarks:** LG and webOS are trademarks of LG Electronics. Netflix, YouTube, Disney+, Prime Video, Apple TV and the other names shown are trademarks of their owners. Slopium is **not affiliated with, endorsed by or sponsored by** LG Electronics or any of these companies.
- **Weather data** is provided by Open-Meteo.
- Credits and licences for the code, fonts and icons that Slopium builds on are in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## 5. No advice

Nothing in this repository is legal, technical or financial advice. Check the rules that apply to you (warranty terms, local law, the terms of your streaming services) before modifying a TV.
