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

# ---------------------------------------------------------------- 1. the code
CODE="${WORKSHOP_CODE:-}"
if [ -z "$CODE" ]; then
  printf "Paste the workshop code from your seat card, then press Enter.\n(The screen will not show it as you paste.)\n> "
  read -rs CODE </dev/tty
  echo
fi
CODE="$(printf '%s' "$CODE" | tr -d '[:space:]')"
[ -n "$CODE" ] || die "No code entered." \
  "Re-run: bash setup.sh   — then paste the code from your seat card."

# ------------------------------------------------------- 2. fetch the bundle
echo "Unlocking workshop materials..."
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
if ! git clone --depth 1 --quiet \
      "https://x-access-token:${CODE}@github.com/${CORPUS_REPO}.git" \
      "$TMP/bundle" 2>"$TMP/err"; then
  die "That workshop code was rejected." \
      "Check for a missing character or a stray space, then re-run: bash setup.sh"
fi
echo "✅ Code accepted."

# --------------------------------------------------------------- 3. the corpus
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

# ------------------------------------------------------------ 4. model access
OPENROUTER_API_KEY="$(tr -d '[:space:]' < "$TMP/bundle/openrouter.key" 2>/dev/null || true)"
[ -n "$OPENROUTER_API_KEY" ] || die "The bundle is missing the model key." \
      "This is a facilitator-side problem, not yours. Raise a hand."
export OPENROUTER_API_KEY

echo "Checking model access..."
HTTP="$(curl -s -m 20 -o "$TMP/keycheck.json" -w '%{http_code}' \
  https://openrouter.ai/api/v1/key \
  -H "Authorization: Bearer ${OPENROUTER_API_KEY}" || echo 000)"
case "$HTTP" in
  200) echo "✅ Model access OK." ;;
  000) die "Could not reach OpenRouter (network)." \
           "Check your wifi, then re-run: bash setup.sh" ;;
  401|402|403) die "The workshop model key was rejected (HTTP $HTTP)." \
           "This is a facilitator-side problem, not yours. Raise a hand." ;;
  *)   die "Unexpected response from OpenRouter (HTTP $HTTP)." \
           "Re-run: bash setup.sh   — if it repeats, raise a hand." ;;
esac

# --------------------------------------------------------- 5. configure agent
command -v openclaw >/dev/null 2>&1 || die "OpenClaw is not installed yet." \
  "The container may still be finishing. Wait 30 seconds, then re-run: bash setup.sh"

echo "Configuring OpenClaw..."
openclaw onboard --auth-choice apiKey \
  --token-provider openrouter \
  --token "$OPENROUTER_API_KEY" >/dev/null 2>&1 || true

python3 - "$MODEL" <<'PYEOF'
import json, os, sys
model = sys.argv[1]
path = os.path.expanduser("~/.openclaw/openclaw.json")
cfg = {}
if os.path.exists(path):
    with open(path) as f:
        try: cfg = json.load(f)
        except Exception: cfg = {}
cfg.setdefault("env", {})["OPENROUTER_API_KEY"] = os.environ["OPENROUTER_API_KEY"]
agents = cfg.setdefault("agents", {}).setdefault("defaults", {})
agents.setdefault("model", {})["primary"] = model
agents.setdefault("models", {})[model] = {}
os.makedirs(os.path.dirname(path), exist_ok=True)
with open(path, "w") as f:
    json.dump(cfg, f, indent=2)
print("✅ OpenClaw pinned to", model)
PYEOF

echo
hr
echo "  READY."
echo
echo "  Start the agent:   openclaw"
echo "  Papers:            corpus/papers/   (${COUNT} files)"
echo "  Exercises:         exercises/"
hr
