# Keeping this environment after today

**Be clear about what is yours to keep.** The environment you used today is
temporary by design: it holds papers ASEE licensed for this session only, and a
model key that belongs to the workshop, and both go away. What you keep is
everything needed to stand the same environment back up with your own key and
your own documents — the repository, the setup script, the prompts, and the
exercises. That is the durable takeaway, and it is about ten minutes of work
below.

Your seat-card code stops working after the conference, and the AI key it
fetched goes with it. Your Codespace keeps working until you delete it or
GitHub retires it after 30 days of inactivity, but a fresh one will not have
a key. Here is how to have your own, for about the cost of a lunch.

**First, before you leave: delete today's Codespace.** It holds ASEE-licensed
papers and the workshop credential, and retiring it is a condition of the
permission that let us use the papers at all. Only you can do it — it is in
your account. Save your report and brief first, then go to
<https://github.com/codespaces> and delete the one named after
**asee-mw-2026-agentic-ai-workshop**. Nothing below depends on it surviving.

---

1. **Fork the repo.** On
   <https://github.com/jhassell/asee-mw-2026-agentic-ai-workshop> click
   **Fork**. You now own a copy.
2. **Get a model key.** Create an account at <https://openrouter.ai>, add
   $10 of credit, and create an API key. Copy it somewhere safe. Do not use
   a model whose name ends in `:free`; those are capped at 20 requests a
   minute for your whole account.
3. **Open a Codespace on your fork** (Code > Codespaces > Create codespace
   on main).
4. **Create one file and run setup.** In the terminal:
   ```
   nano my-openrouter.key
   ```
   Paste your key on one line, press Ctrl+O, Enter, Ctrl+X. Then:
   ```
   bash setup.sh
   ```
   With that file present, setup skips the workshop code, applies the same
   configuration the workshop used, and prints READY. Start the agent with
   `openclaw chat`, as before. The file is gitignored and cannot be
   committed by accident.
5. **The ASEE papers are not in your fork and cannot be.** The permission
   covered this session only. Put your own papers, syllabi, or student-safe
   Markdown or text documents in `corpus/papers/`. The your-idea prompt
   works on them as is. The pass-2 coverage spec expects YAML frontmatter
   (`paper_id`, `title`, `key_terms`) and an `## Abstract` heading; on
   your own files, rewrite its first sentence to say what they contain.

What it costs: a session like today's uses well under a dollar. A student
running the starter assignment for a week uses roughly two to five dollars.
