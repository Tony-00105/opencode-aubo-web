#!/bin/bash
# Install the system packages this machine setup needs.
set -euo pipefail

sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  fcitx5 \
  fcitx5-chinese-addons \
  fcitx5-frontend-gtk3 \
  fcitx5-frontend-gtk4 \
  fcitx5-frontend-qt5 \
  fcitx5-frontend-qt6 \
  fcitx5-config-qt \
  zenity \
  expect

echo "packages installed"
