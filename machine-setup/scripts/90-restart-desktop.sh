#!/bin/bash
# Restart the XFCE desktop session so the new environment variables reach
# every GUI app. On instabox the desktop is Xvnc :1 + xfce4-session.
# This closes the browser and any open windows (files stay on disk).
set -uo pipefail

if ! command -v instabox-desktop >/dev/null 2>&1; then
  echo "instabox-desktop not found: this is not an instabox desktop sandbox."
  echo "Log out and back in instead."
  exit 0
fi

export DISPLAY="${DISPLAY:-:1}"

echo "closing chromium gracefully (so its profile/cookies are flushed)"
pkill -TERM -f "/usr/lib/chromium/chromium" 2>/dev/null || true
for _ in $(seq 1 20); do pgrep -f "/usr/lib/chromium/chromium" >/dev/null || break; sleep 0.5; done
pkill -KILL -f "/usr/lib/chromium/chromium" 2>/dev/null || true

echo "stopping the session"
pkill -TERM -x fcitx5 2>/dev/null || true
pkill -TERM -x xfce4-terminal 2>/dev/null || true
pkill -TERM -x xfdesktop 2>/dev/null || true
pkill -TERM -x xfce4-panel 2>/dev/null || true
pkill -TERM -x xfwm4 2>/dev/null || true
pkill -TERM -x xfce4-session 2>/dev/null || true
for _ in $(seq 1 20); do pgrep -x xfce4-session >/dev/null || break; sleep 0.5; done
pkill -KILL -x xfce4-session 2>/dev/null || true

# instabox-desktop only starts a session when the VNC server is not listening,
# so the X server has to go too.
pkill -TERM -x Xvnc 2>/dev/null || true
for _ in $(seq 1 20); do pgrep -x Xvnc >/dev/null || break; sleep 0.5; done
pkill -KILL -x Xvnc 2>/dev/null || true
rm -f /tmp/.X11-unix/X1 /tmp/.X1-lock

sleep 1
instabox-desktop start 2>&1 | tail -5
sleep 6

echo "--- running ---"
ps -eo pid,args | grep -E "[X]vnc|[x]fce4-session|[f]citx5" || true
