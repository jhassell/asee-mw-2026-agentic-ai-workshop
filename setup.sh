#!/usr/bin/env bash
# ASEE MW 2026 — "From Chatbots to Agents" workshop setup.
# Run this once, with your seat card in hand:   bash setup.sh
#
# One paste. The workshop code on your card unlocks both the model access
# and the paper corpus. Nothing sensitive is printed on the card itself.
set -uo pipefail

CORPUS_REPO="jhassell/asee-mw-2026-corpus"   # private; read-only code required
MODEL="openrouter/google/gemini-3.7-flash"
# Pinned, not @latest — see .devcontainer/devcontainer.json for why. These
# must stay in step with the versions postCreate.sh installs.
OPENCLAW_VERSION="2026.9.2"
PANDAS_VERSION="3.0.5"
MATPLOTLIB_VERSION="3.11.1"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

hr() { echo "=============================================="; }
die() {
  echo
  echo "❌ $1"
  echo
  echo "   $2"
  echo "   Still stuck? Raise a hand — a facilitator will sort it out."
  exit 1
}

hr; echo " From Chatbots to Agents — setup"; hr
# Print the revision. With 24 screens in a room, "which version is that one on?"
# has to be answerable from across the room without asking anyone to type.
echo "Workshop files: $(git -C "$ROOT" rev-parse --short HEAD 2>/dev/null || echo unknown)"

# ---------------------------------------------------- 0. latest exercises
# A Codespace created before the conference has whatever was pushed then.
# Best effort: pull the current files, never fail setup over it.
BEFORE_PULL="$(git -C "$ROOT" rev-parse HEAD 2>/dev/null || echo none)"
if git -C "$ROOT" pull --ff-only --quiet 2>/dev/null; then
  AFTER_PULL="$(git -C "$ROOT" rev-parse HEAD 2>/dev/null || echo none)"
  if [ "$BEFORE_PULL" != "$AFTER_PULL" ]; then
    # The pull just replaced this file on disk, but bash is still executing
    # the OLD one from its open file handle, so without this the rest of the
    # run uses stale logic. Restart once, into the version we just fetched.
    #
    # Note what this does NOT fix: a Codespace created before 2026-09-09 has a
    # setup.sh that predates this block, so its first run cannot re-exec. That
    # case was measured — run 1 pulls the fix and fails at the old OpenClaw
    # check, run 2 self-heals completely — and the old script's own error text
    # already says "re-run: bash setup.sh". Cleanest recovery is still to
    # delete that Codespace and create a fresh one.
    #
    # WORKSHOP_SETUP_REEXEC bounds this to one restart, so a repo that
    # legitimately updates on every run cannot loop.
    if [ -z "${WORKSHOP_SETUP_REEXEC:-}" ]; then
      export WORKSHOP_SETUP_REEXEC=1
      echo "Exercise files updated — restarting with the current version."
      exec bash "$ROOT/setup.sh" "$@"
    fi
  fi
  echo "Exercise files are up to date."
else
  echo "Could not refresh exercise files (offline or local edits); continuing."
fi

# ------------------------------------------------------------- 0.5 tooling
# Everything that does not need your seat card happens first, so a container
# problem surfaces before you type a 93-character code rather than after.
#
# The container normally installs these at creation. If that failed — as it
# did on 2026-09-08, when an upstream release bumped its Node requirement —
# repair it here rather than telling you to wait and try again.
if ! command -v openclaw >/dev/null 2>&1; then
  echo "Installing the agent (about a minute; this only happens once)..."
  for attempt in 1 2 3; do
    npm install -g "openclaw@${OPENCLAW_VERSION}" >/tmp/openclaw-install.log 2>&1 && break
    echo "   attempt ${attempt} did not succeed; retrying..."
    sleep 5
  done
  hash -r
fi
command -v openclaw >/dev/null 2>&1 || die "The agent could not be installed." \
  "Show a facilitator the last few lines of /tmp/openclaw-install.log"
echo "✅ Agent installed — $(openclaw --version 2>/dev/null | head -1)"

# The charting libraries the agent uses in pass 2. Quiet unless they are absent.
python3 -c 'import pandas, matplotlib' 2>/dev/null || {
  echo "Installing charting libraries..."
  pip install --user --quiet "pandas==${PANDAS_VERSION}" \
      "matplotlib==${MATPLOTLIB_VERSION}" >/tmp/charting-install.log 2>&1 || true
  # Say so if it did not work. Otherwise the first symptom is pass 2 failing
  # to draw its chart with the clock running.
  python3 -c 'import pandas, matplotlib' 2>/dev/null || {
    echo "⚠️  The charting libraries did not install. Everything else will work;"
    echo "   the agent may not be able to draw the chart in pass 2. Mention this"
    echo "   to a facilitator when you get there — it is not urgent now."
  }
}

# ------------------------------------------------- 1. code, or your own key
# Two ways in. At the workshop: the seat-card code, which unlocks the papers
# and the model key. Afterwards: a file named my-openrouter.key in this
# folder containing your own OpenRouter key (see exercises/keep-it-running.md).
# *.key is gitignored, so it can never be committed.
OWN_KEY_FILE="$ROOT/my-openrouter.key"
OWN=0
if [ -z "${WORKSHOP_CODE:-}" ] && [ -s "$OWN_KEY_FILE" ]; then
  OWN=1
  echo "Using your own key from my-openrouter.key (no workshop code needed)."
fi
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

if [ "$OWN" -eq 0 ]; then
  # Up to three tries in one run. A mistyped 93-character code should cost a
  # re-paste, not a re-run of the whole script.
  ATTEMPT=0
  while :; do
    ATTEMPT=$((ATTEMPT + 1))
    CODE="${WORKSHOP_CODE:-}"
    if [ -z "$CODE" ]; then
      echo
      echo "Paste the workshop code from your seat card, then press Enter."
      echo "Nothing will appear on the screen while you paste. That is normal —"
      echo "the code is hidden on purpose. Paste once, then press Enter."
      printf "> "
      read -rs CODE </dev/tty
      echo
    fi
    CODE="$(printf '%s' "$CODE" | tr -d '[:space:]')"
    if [ "${#CODE}" -eq 1 ]; then echo "Received 1 character."; else echo "Received ${#CODE} characters."; fi
    if [ "${#CODE}" -lt 20 ]; then
      if [ "$ATTEMPT" -ge 3 ] || [ -n "${WORKSHOP_CODE:-}" ]; then
        die "No code was received." \
            "Try selecting the code on your card and typing it in full, or raise a hand."
      fi
      echo "   That looks too short — the code is about 93 characters. Let's try again."
      continue
    fi

    # --------------------------------------------------- 2. fetch the bundle
    echo "Unlocking workshop materials..."
    if git clone --depth 1 --quiet \
          "https://x-access-token:${CODE}@github.com/${CORPUS_REPO}.git" \
          "$TMP/bundle" 2>"$TMP/err"; then
      break
    fi
    rm -rf "$TMP/bundle"
    if [ "$ATTEMPT" -ge 3 ] || [ -n "${WORKSHOP_CODE:-}" ]; then
      die "That workshop code was rejected three times." \
          "Raise a hand — a facilitator will check the code on your card."
    fi
    echo "   That code was not accepted — a character is probably missing."
    echo "   Let's try once more."
  done
  echo "✅ Code accepted."

  # ------------------------------------------------------------- 3. the corpus
  if [ ! -d "$TMP/bundle/papers" ]; then
    die "The bundle downloaded but contains no papers/ folder." \
        "This is a facilitator-side problem, not yours. Raise a hand."
  fi
  mkdir -p "$ROOT/corpus/papers"
  cp "$TMP/bundle/papers/"*.md "$ROOT/corpus/papers/" 2>/dev/null
  COUNT="$(find "$ROOT/corpus/papers" -name '*.md' | wc -l | tr -d ' ')"
  [ "$COUNT" -gt 0 ] || die "No papers were copied." \
        "Re-run: bash setup.sh   — if it repeats, raise a hand."
  echo "✅ Corpus ready — ${COUNT} papers in corpus/papers/"
  OPENROUTER_API_KEY="$(tr -d '[:space:]' < "$TMP/bundle/openrouter.key" 2>/dev/null || true)"
  [ -n "$OPENROUTER_API_KEY" ] || die "The bundle is missing the model key." \
        "This is a facilitator-side problem, not yours. Raise a hand."
else
  # Own-key mode: no workshop papers (the ASEE permission covered the
  # session only). Use whatever .md files you put in corpus/papers/.
  mkdir -p "$ROOT/corpus/papers"
  COUNT="$(find "$ROOT/corpus/papers" -name '*.md' | wc -l | tr -d ' ')"
  echo "ℹ️  corpus/papers/ holds ${COUNT} .md files. Add your own documents there."
  OPENROUTER_API_KEY="$(tr -d '[:space:]' < "$OWN_KEY_FILE")"
  [ -n "$OPENROUTER_API_KEY" ] || die "my-openrouter.key is empty." \
        "Paste your OpenRouter key into that file (one line) and re-run: bash setup.sh"
fi
export OPENROUTER_API_KEY

# ------------------------------------------------------------ 4. model access
echo "Checking model access..."
HTTP="$(curl -s -m 20 -o "$TMP/keycheck.json" -w '%{http_code}' \
  https://openrouter.ai/api/v1/key \
  -H "Authorization: Bearer ${OPENROUTER_API_KEY}" || echo 000)"
case "$HTTP" in
  200) echo "✅ Model access OK." ;;
  000) die "Could not reach OpenRouter (network)." \
           "Check your wifi, then re-run: bash setup.sh" ;;
  401|402|403) if [ "$OWN" -eq 1 ]; then
           die "OpenRouter rejected the key in my-openrouter.key (HTTP $HTTP)." \
               "Check the key at openrouter.ai/settings/keys, fix the file, re-run: bash setup.sh"
         else
           die "The workshop model key was rejected (HTTP $HTTP)." \
               "This is a facilitator-side problem, not yours. Raise a hand."
         fi ;;
  *)   die "Unexpected response from OpenRouter (HTTP $HTTP)." \
           "Re-run: bash setup.sh   — if it repeats, raise a hand." ;;
esac

# --------------------------------------------------------- 5. configure agent
echo "Configuring OpenClaw..."
export WORKSHOP_ROOT="$ROOT"
# Write the config directly (OpenClaw 2026.9 schema): the key under env.vars,
# the model pinned as primary and allow-listed, memory search off (it would
# otherwise try to reach an OpenAI embeddings endpoint and log errors on every
# turn). Then let doctor normalize anything version-specific.
python3 - "$MODEL" <<'PYEOF'
import json, os, sys
model = sys.argv[1]
path = os.path.expanduser("~/.openclaw/openclaw.json")
cfg = {}
if os.path.exists(path):
    with open(path) as f:
        try: cfg = json.load(f)
        except Exception: cfg = {}
cfg.setdefault("env", {}).setdefault("vars", {})["OPENROUTER_API_KEY"] = os.environ["OPENROUTER_API_KEY"]
d = cfg.setdefault("agents", {}).setdefault("defaults", {})
d.setdefault("model", {})["primary"] = model
d.setdefault("modelPolicy", {})["allow"] = [model]
d.pop("models", None)
# Run the agent inside the workshop repo so coverage-report.md, coverage.png
# and my-positioning.md land where the editor shows them.
d["cwd"] = os.environ["WORKSHOP_ROOT"]
cfg.setdefault("memory", {}).setdefault("search", {})["enabled"] = False
os.makedirs(os.path.dirname(path), exist_ok=True)
with open(path, "w") as f:
    json.dump(cfg, f, indent=2)
print("✅ OpenClaw pinned to", model)
PYEOF
openclaw doctor --fix >/dev/null 2>&1 || true
# OpenClaw's workspace ships a first-run "introduce yourself and pick a name"
# ritual (BOOTSTRAP.md) that would hijack a participant's first prompt.
# Remove it and give the agent a fixed identity.
WS="$HOME/.openclaw/workspace"
mkdir -p "$WS"
rm -f "$WS/BOOTSTRAP.md"
cat > "$WS/IDENTITY.md" <<'IDEOF'
# IDENTITY.md - Who Am I?

- **Name:** Workshop Agent
- **Creature:** AI coding agent
- **Vibe:** plain, careful, shows its work
- **Emoji:** 🔧
IDEOF
if ! openclaw config validate >/dev/null 2>&1; then
  die "OpenClaw did not accept its configuration." \
      "Re-run: bash setup.sh   — if it repeats, raise a hand."
fi
echo "✅ OpenClaw configuration valid."

echo
hr
echo "  READY."
echo
echo "  Start the agent:   openclaw chat"
echo "  Papers:            corpus/papers/   (${COUNT} files)"
echo "  Exercises:         exercises/"
hr
