#!/usr/bin/env bash
set -euo pipefail

echo "=== Iron Atlas USB Check ==="
echo
echo "[1] USB devices:"
lsusb || true
echo
echo "[2] Serial by-id:"
ls -l /dev/serial/by-id 2>/dev/null || echo "No /dev/serial/by-id entries found."
echo
echo "[3] Stable symlinks:"
for d in /dev/ironatlas-gps /dev/ironatlas-mesh; do
  if [ -e "$d" ]; then
    echo "OK: $d -> $(readlink -f "$d")"
  else
    echo "MISSING: $d"
  fi
done
echo
echo "[4] Current tty devices:"
ls -l /dev/ttyACM* /dev/ttyUSB* 2>/dev/null || echo "No ttyACM/ttyUSB devices detected."
echo
echo "Done."
