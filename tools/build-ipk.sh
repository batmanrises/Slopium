#!/bin/bash
# Builds the installable Slopium package (.ipk) from this repository.
# Needs: bash, tar, gzip, ar (binutils). No Node or npm required.
#   ./tools/build-ipk.sh          -> build/io.github.batmanrises.slopium_<version>_all.ipk
set -euo pipefail
cd "$(dirname "$0")/.."

APP_ID="io.github.batmanrises.slopium"
VERSION="$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' app/appinfo.json | head -n1)"
[ -n "$VERSION" ] || { echo "Could not read the version from app/appinfo.json" >&2; exit 1; }

WORK="$(mktemp -d)"; trap 'rm -rf "$WORK"' EXIT
mkdir -p "$WORK/data/usr/palm/applications/$APP_ID" "$WORK/data/usr/palm/packages/$APP_ID" "$WORK/ctrl"

cp -r app/. "$WORK/data/usr/palm/applications/$APP_ID/"
sed "s/\"version\": *\"[^\"]*\"/\"version\": \"$VERSION\"/" packaging/packageinfo.json \
  > "$WORK/data/usr/palm/packages/$APP_ID/packageinfo.json"

SIZE="$(du -sk "$WORK/data" | cut -f1)"
sed -e "s/^Version: .*/Version: $VERSION/" -e "s/^Installed-Size: .*/Installed-Size: $SIZE/" \
  packaging/control > "$WORK/ctrl/control"
cp packaging/debian-binary "$WORK/debian-binary"

TAROPTS=(--owner=0 --group=0 --numeric-owner --mode='u+rwX,go+rX,go-w')
( cd "$WORK/ctrl" && tar "${TAROPTS[@]}" -czf "$WORK/control.tar.gz" ./control )
( cd "$WORK/data" && tar "${TAROPTS[@]}" -czf "$WORK/data.tar.gz" ./usr )

mkdir -p build
OUT="build/${APP_ID}_${VERSION}_all.ipk"
rm -f "$OUT"
( cd "$WORK" && ar rc "$OLDPWD/$OUT" debian-binary control.tar.gz data.tar.gz )
echo "Built $OUT"
