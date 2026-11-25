#!/bin/bash
# Configure fcitx5 with Chinese pinyin for the XFCE desktop session.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
CFG="$ROOT/config"

# Session-wide environment (the desktop inherits it from a login shell).
sudo install -m 0644 "$CFG/90-fcitx5.sh" /etc/profile.d/90-fcitx5.sh

# systemd user environment (dbus-activated apps and user services).
mkdir -p "$HOME/.config/environment.d"
install -m 0644 "$CFG/environment.d/90-fcitx5.conf" "$HOME/.config/environment.d/90-fcitx5.conf"

# X session fallback.
install -m 0644 "$CFG/90-fcitx5.sh" "$HOME/.xprofile"

# Autostart inside XFCE.
mkdir -p "$HOME/.config/autostart"
install -m 0644 "$CFG/autostart/fcitx5.desktop" "$HOME/.config/autostart/fcitx5.desktop"

# keyboard-us + pinyin, Chinese active by default.
mkdir -p "$HOME/.config/fcitx5"
install -m 0644 "$CFG/fcitx5/profile" "$HOME/.config/fcitx5/profile"
install -m 0644 "$CFG/fcitx5/config" "$HOME/.config/fcitx5/config"

# Restart the daemon so the profile applies now.
fcitx5 -r -d >/dev/null 2>&1 || true

echo "fcitx5 configured (toggle: Ctrl+Space)"
