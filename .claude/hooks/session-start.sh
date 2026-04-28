#!/bin/bash
set -euo pipefail

# Only run in remote (Claude Code on the web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install htmlhint for linting HTML files
npm install --no-fund --no-audit htmlhint

# Show current git state for orientation
echo ""
echo "=== Baker Hub Session Start ==="
echo "Branch : $(git branch --show-current)"
echo "Version: $(grep -o 'baker-hub-v[0-9.]*' sw.js | head -1)"
echo "Latest : $(git log --oneline -3)"
echo "================================"
