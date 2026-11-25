#!/bin/bash
# Recreate this machine's desktop configuration on an instabox sandbox.
# Run as the sandbox user (not root).
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"

echo "== 1/3 packages =="
bash "$HERE/scripts/10-packages.sh"

echo "== 2/3 chinese input method =="
bash "$HERE/scripts/20-fcitx5-chinese.sh"

echo "== 3/3 desktop session =="
echo "The desktop session has to restart for the environment to apply."
echo "Run this when you are ready (it closes the browser):"
echo
echo "  bash $HERE/scripts/90-restart-desktop.sh"
echo
echo "Done. Toggle Chinese with Ctrl+Space."
