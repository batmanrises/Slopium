#!/bin/bash
# Builds the installable Slopium package (.ipk) from this repository.
# Needs only: bash, tar (GNU), gzip, wc, sed, du, date. No Node, npm or "ar" tool required,
# so it also runs in Git Bash on Windows.
#   bash tools/build-ipk.sh       -> build/io.github.batmanrises.slopium_<version>_all.ipk
#
# The package is written in the same layout that ares-package produces, because the
# installer on older webOS versions (for example webOS 5) is strict about it:
#   * tar archives in plain "ustar" format (no GNU long-name records),
#     with file names that start at "usr/..." and stay under 100 characters;
#   * ar archive members named exactly "debian-binary", "control.tar.gz" and
#     "data.tar.gz" (no trailing "/"), in that order.
set -euo pipefail
export LC_ALL=C
cd "$(dirname "$0")/.."

APP_ID="io.github.batmanrises.slopium"
VERSION="$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' app/appinfo.json | head -n1)"
[ -n "$VERSION" ] || { echo "Could not read the version from app/appinfo.json" >&2; exit 1; }
EPOCH="${SOURCE_DATE_EPOCH:-$(date +%s)}"

WORK="$(mktemp -d)"; trap 'rm -rf "$WORK"' EXIT
mkdir -p "$WORK/data/usr/palm/applications/$APP_ID" "$WORK/data/usr/palm/packages/$APP_ID" "$WORK/ctrl"

cp -r app/. "$WORK/data/usr/palm/applications/$APP_ID/"
sed "s/\"version\": *\"[^\"]*\"/\"version\": \"$VERSION\"/" packaging/packageinfo.json \
  > "$WORK/data/usr/palm/packages/$APP_ID/packageinfo.json"

# Installed-Size is in bytes, like ares-package writes it.
SIZE="$(du -sb "$WORK/data" 2>/dev/null | cut -f1 || true)"
[ -n "$SIZE" ] || SIZE="$(( $(du -sk "$WORK/data" | cut -f1) * 1024 ))"
sed -e "s/^Version: .*/Version: $VERSION/" -e "s/^Installed-Size: .*/Installed-Size: $SIZE/" \
  packaging/control > "$WORK/ctrl/control"
cp packaging/debian-binary "$WORK/debian-binary"

# ustar fails loudly if a path is too long to store, instead of writing a format old TVs cannot read.
TAROPTS=(--format=ustar --owner=0 --group=0 --numeric-owner --sort=name --mtime="@$EPOCH" --mode='u+rwX,go+rX,go-w')
( cd "$WORK/ctrl" && tar "${TAROPTS[@]}" -czf "$WORK/control.tar.gz" control )
( cd "$WORK/data" && tar "${TAROPTS[@]}" -czf "$WORK/data.tar.gz" usr )

# Write the ar archive by hand: 8-byte signature, then for each file a 60-byte header
# (name, time, uid, gid, mode, size) followed by the data, padded to an even length.
ar_add() {
  local file="$1" name="$2" size
  size="$(wc -c < "$file" | tr -d ' ')"
  printf '%-16s%-12s%-6s%-6s%-8s%-10s`\n' "$name" "$EPOCH" 0 0 100644 "$size"
  cat "$file"
  if [ $((size % 2)) -eq 1 ]; then printf '\n'; fi
}

mkdir -p build
OUT="build/${APP_ID}_${VERSION}_all.ipk"
rm -f "$OUT"
{
  printf '!<arch>\n'
  ar_add "$WORK/debian-binary" "debian-binary"
  ar_add "$WORK/control.tar.gz" "control.tar.gz"
  ar_add "$WORK/data.tar.gz" "data.tar.gz"
} > "$OUT"
echo "Built $OUT"
