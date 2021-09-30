#!/bin/bash
FQBN="arduino:avr:leonardo"
PORT=$(arduino-cli board list | grep "$FQBN" | grep -o "^[^ ]*")
make
mkdir -p /tmp/arduino-sketch-7A46BFED1532788A0F959EB0D3D86256/
cp ./toaster.hex /tmp/arduino-sketch-7A46BFED1532788A0F959EB0D3D86256/toaster.ino.hex
arduino-cli upload -v -p "$PORT" --fqbn "$FQBN"
