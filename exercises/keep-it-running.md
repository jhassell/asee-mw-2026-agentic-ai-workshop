# Keeping this environment after today

Your seat-card code stops working after the conference, and the AI key it
fetched goes with it. Your Codespace keeps working until you delete it or
GitHub retires it after 30 days of inactivity, but a fresh one will not have
a key. Here is how to have your own, for about the cost of a lunch.

1. **Fork the repo.** On
   <https://github.com/jhassell/asee-mw-2026-agentic-ai-workshop> click
   **Fork**. You now own a copy.
2. **Get a model key.** Create an account at <https://openrouter.ai>, add
   $10 of credit, and create an API key. Copy it somewhere safe. Do not use
   a model whose name ends in `:free`; those are capped at 20 requests a
   minute for your whole account.
3. **Open a Codespace on your fork** (Code > Codespaces > Create codespace
   on main).
4. **In the terminal:**
   ```
   openclaw onboard
   ```
   Paste your OpenRouter key when asked. Then open
   `~/.openclaw/openclaw.json` and confirm the model under `agents.defaults`
   is `openrouter/google/gemini-3.7-flash`, or any model you prefer.
5. **The ASEE papers are not in your fork and cannot be.** The permission
   covered this session only. Put your own papers, syllabi, or student-safe
   documents in `corpus/papers/` and the prompts work unchanged.

What it costs: a session like today's uses well under a dollar. A student
running the starter assignment for a week uses roughly two to five dollars.
