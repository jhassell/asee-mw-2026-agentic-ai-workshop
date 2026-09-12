#!/usr/bin/env bash
# Runs as the devcontainer's onCreateCommand: inside the Codespaces prebuild, so the
# tools are baked into the prebuilt image, or once at creation if no prebuild exists.
#
# Deliberately NO blanket `set -e`. On 2026-09-08 the openclaw install failed
# and took pandas/matplotlib down with it, so a participant lost both the
# agent and the charting libraries from one error they never saw. Every step
# now runs, reports, and leaves a log; setup.sh re-checks and repairs.

LOG=/tmp/workshop-postcreate.log
exec > >(tee -a "$LOG") 2>&1

# OpenClaw is PINNED, not @latest. openclaw@2026.9.3 (published 2026-09-08)
# raised its Node floor to >=24.16.0 and its preinstall script exits 1 on the
# Node 22 in this image. 2026.9.2 is the release this workshop was built,
# tested and rehearsed against. Do NOT change this to @latest before 09-15.
OPENCLAW_VERSION="2026.9.2"

echo "Installing workshop tooling (OpenClaw ${OPENCLAW_VERSION})..."
ok=0
for attempt in 1 2 3; do
  if npm install -g "openclaw@${OPENCLAW_VERSION}"; then ok=1; break; fi
  echo "npm attempt ${attempt} failed; retrying in 5s..."
  sleep 5
done
if [ "$ok" -eq 1 ]; then
  echo "OpenClaw ${OPENCLAW_VERSION} installed."
else
  echo "OpenClaw did not install here — setup.sh will install it."
fi

# Pinned like everything else in this container — these are the versions the
# pass-2 charting step was verified against on 2026-09-09.
PANDAS_VERSION="3.0.5"
MATPLOTLIB_VERSION="3.11.1"
if pip install --user --quiet "pandas==${PANDAS_VERSION}" "matplotlib==${MATPLOTLIB_VERSION}"; then
  echo "pandas + matplotlib installed."
else
  echo "pandas/matplotlib did not install here — setup.sh will install them."
fi

# GATE. Each install above tolerates failure so one error cannot take the other
# down, but a prebuild must not be marked ready without the tools in it: that would
# silently send all 24 participants through the slow repair in setup.sh. Check the
# real thing, not a log line, and fail the lifecycle command if either is missing.
FAIL=
openclaw --version 2>/dev/null | grep -qF "$OPENCLAW_VERSION" \
  || { echo "GATE FAILED: openclaw ${OPENCLAW_VERSION} is not installed"; FAIL=1; }
python3 -c 'import pandas, matplotlib' 2>/dev/null \
  || { echo "GATE FAILED: pandas/matplotlib do not import"; FAIL=1; }
if [ -n "$FAIL" ]; then
  echo "Tooling incomplete. In a participant Codespace, bash setup.sh repairs it."
  exit 1
fi
echo "GATE PASSED: openclaw ${OPENCLAW_VERSION}, pandas, matplotlib"

echo ""
echo "=============================================="
echo " Container ready."
echo " Next step:  bash setup.sh   (seat card in hand)"
echo "=============================================="
