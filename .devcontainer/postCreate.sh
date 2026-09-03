#!/usr/bin/env bash
# Runs once when the Codespace is created (and is baked into prebuilds).
set -e
echo "Installing workshop tooling..."
npm install -g openclaw@latest
pip install --user pandas matplotlib
echo ""
echo "=============================================="
echo " Container ready."
echo " Next step:  bash setup.sh   (key card in hand)"
echo "=============================================="
