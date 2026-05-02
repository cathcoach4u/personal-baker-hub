#!/usr/bin/env bash
# Usage: bash bump-version.sh 6.16
# Updates the version badge in every file that shows it.
set -e

NEW=$1
if [ -z "$NEW" ]; then
  echo "Usage: bash bump-version.sh <new-version>  e.g. bash bump-version.sh 6.16"
  exit 1
fi

DIR="$(cd "$(dirname "$0")" && pwd)"

# Detect current version from sw.js
OLD=$(grep -oP '(?<=baker-hub-v)[0-9]+\.[0-9]+' "$DIR/sw.js")
echo "Bumping v$OLD → v$NEW"

# sw.js cache name
sed -i "s/baker-hub-v${OLD}/baker-hub-v${NEW}/g" "$DIR/sw.js"

# index.html — two badges
sed -i "s/>v${OLD}<\\/span>/>v${NEW}<\\/span>/g" "$DIR/index.html"

# All 5 Japan pages
for f in japan-2026 japan-itinerary japan-plan japan-budget japan-info; do
  sed -i "s/>v${OLD}<\\/span>/>v${NEW}<\\/span>/g" "$DIR/${f}.html"
done

# CLAUDE.md version references
sed -i "s/baker-hub-v${OLD}/baker-hub-v${NEW}/g" "$DIR/Personal-hub/CLAUDE.md"
sed -i "s/Current version\*\* — v${OLD}/Current version** — v${NEW}/g" "$DIR/Personal-hub/CLAUDE.md"

echo "Done — all files updated to v$NEW"
echo "Files changed:"
grep -l "v${NEW}" "$DIR/sw.js" "$DIR/index.html" \
  "$DIR/japan-2026.html" "$DIR/japan-itinerary.html" "$DIR/japan-plan.html" \
  "$DIR/japan-budget.html" "$DIR/japan-info.html" "$DIR/Personal-hub/CLAUDE.md"
