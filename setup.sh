#!/usr/bin/env bash
# ASEE MW 2026 — "From Chatbots to Agents" workshop setup.
# Run this once, with your seat card in hand:   bash setup.sh
#
# One paste. The workshop code on your card unlocks both the model access
# and the paper corpus. Nothing sensitive is printed on the card itself.
set -uo pipefail

CORPUS_REPO="jhassell/asee-mw-2026-corpus"   # private; read-only code required
MODEL="openrouter/google/gemini-3.7-flash"
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

# ---------------------------------------------------- 0. latest exercises
# A Codespace created before the conference has whatever was pushed then.
# Best effort: pull the current files, never fail setup over it.
if git -C "$ROOT" pull --ff-only --quiet 2>/dev/null; then
  echo "Exercise files are up to date."
else
  echo "Could not refresh exercise files (offline or local edits); continuing."
fi

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
  CODE="${WORKSHOP_CODE:-}"
  if [ -z "$CODE" ]; then
    printf "Paste the workshop code from your seat card, then press Enter.\n(The screen will not show it as you paste.)\n> "
    read -rs CODE </dev/tty
    echo
  fi
  CODE="$(printf '%s' "$CODE" | tr -d '[:space:]')"
  [ -n "$CODE" ] || die "No code entered." \
    "Re-run: bash setup.sh   — then paste the code from your seat card."

  # ----------------------------------------------------- 2. fetch the bundle
  echo "Unlocking workshop materials..."
  if ! git clone --depth 1 --quiet \
        "https://x-access-token:${CODE}@github.com/${CORPUS_REPO}.git" \
        "$TMP/bundle" 2>"$TMP/err"; then
    die "That workshop code was rejected." \
        "Check for a missing character or a stray space, then re-run: bash setup.sh"
  fi
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
command -v openclaw >/dev/null 2>&1 || die "OpenClaw is not installed yet." \
  "The container may still be finishing. Wait 30 seconds, then re-run: bash setup.sh"

echo "Configuring OpenClaw..."
export WORKSHOP_ROOT="$ROOT"
# Write the config directly (OpenClaw 2026.9+ schema): the key under env.vars,
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
