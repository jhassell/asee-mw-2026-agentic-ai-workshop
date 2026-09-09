# From Chatbots to Agents

### A Hands-On Workshop on Teaching with Agentic AI

**2026 ASEE Midwest Section Conference** · University of Oklahoma, Norman ·
September 13–15, 2026
Facilitator: John Hassell, OU Polytechnic Institute — Chair, ASEE Midwest Section

---

## Before you arrive (about 5 minutes)

You need two things. Please do both **before** the session — conference wifi
is not the place to create an account for the first time.

**1. A free GitHub account.**
If you don't have one: <https://github.com/signup>. Any email works. You do
not need a paid plan, and you will not be asked for a credit card.

**2. Confirm you can open a Codespace.**
Sign in to GitHub, come back to this page, and click the green **Code** button
at the top right of the file list. A small panel drops down with **two tabs**:

> **Local**  |  **Codespaces**   ← click the **Codespaces** tab, on the right

The panel opens on **Local** by default, which offers to clone the repository
to your laptop. That is *not* what you want. Click **Codespaces**, then
**Create codespace on main**.

A browser-based editor opens and spends a minute or two building. Along the
way it may ask **"Do you trust the authors of the files in this folder?"** —
click **Yes, I trust the authors** (it is this repository's own files).

That's it — you can close the tab again. Doing this once ahead of time means
you walk into the room with a working environment instead of a signup form.

You do **not** need to install anything on your laptop. You do **not** need
an API key of your own — one is provided at the session.

Bring a laptop that can run a modern browser (Chrome, Edge, Firefox, or
Safari) and that you can type on comfortably for 90 minutes.

---

## At the workshop

You'll receive a **seat card** with a workshop code on it — a long string of
about 93 characters. Then:

0. Join the **OUGuest** wifi. A browser page asks you to accept the terms;
   accept, then check that <https://github.com> loads.

   **If you created your Codespace before September 9**, delete it at
   <https://github.com/codespaces> and create a fresh one. An early one still
   has an old setup script inside it and will make you run `bash setup.sh`
   twice. Deleting costs nothing — you have not put any work in it yet.

1. Open your Codespace: green **Code** button → **Codespaces** tab (the
   right-hand tab, not **Local**) → **Create codespace on main**. If you are
   asked whether you trust the authors of the files in this folder, say yes.

2. A terminal is already open across the bottom of the window. If you don't
   see one, or you close it by accident: **Terminal → New Terminal** from the
   menu, or press <kbd>Ctrl</kbd>+<kbd>`</kbd> (the backtick key, top left of
   the keyboard). In it, run:

   ```bash
   bash setup.sh
   ```

3. When it asks for the workshop code, enter the code from your seat card and
   press Enter. Three things are worth knowing before you do:

   - **Nothing appears on the screen as you type or paste it.** No dots, no
     asterisks, no movement at all. That is deliberate — the code is hidden so
     it can't be read off your screen. It *is* going in.
   - If you paste, Chrome may ask **"Allow this site to see text and images
     copied to the clipboard?"** — click **Allow**. The terminal may then show
     its own warning about pasting multiple characters; choose the option that
     pastes anyway.
   - Right after you press Enter, the script prints **"Received N
     characters."** If N is around 93, the paste worked. If it's small, the
     script offers you another try in place — you don't need to start over.

4. Wait for **READY**. This takes a few seconds.

5. Start the agent:

   ```bash
   openclaw chat
   ```

The setup step downloads the workshop paper corpus and configures the agent
for you. If anything fails, it will tell you exactly what to do next — and
raising a hand is always a valid next step.

---

## What we're doing

You'll run one task three times against a corpus of engineering-education
papers, and watch the output change:

1. **Underspecified.** A vague prompt. Confident, readable, and nothing in it you can check.
2. **Specified.** The same task with explicit scope, format, and acceptance
   criteria, one of which you write yourself. The difference is visible
   immediately.
3. **Verify.** If you don't check the agent's work against something
   outside the agent, you will confidently report things that aren't true.

Then you point the same agent at your own paper or course, and you write
one change to one assignment you teach. The files are in
[`exercises/`](exercises/).

The takeaway is not "AI is good" or "AI is bad." It's that **a fluent answer is
not the same as a trustworthy one.** Trustworthy work from an agent takes three
habits — specifying what you want, supervising while it runs, and verifying the
result against something outside the agent. The third is the one people skip,
and it is the one pass 3 exists to make unskippable. All three are teachable,
and all three are habits your students need.

---

## About the papers

The corpus is drawn from the [ASEE PEER repository](https://peer.asee.org).
ASEE granted permission on 2026-08-26 for use in this workshop specifically:
private, temporary, per-participant environments, for the duration of the
session, with attribution and copyright retained.

The papers are **not** stored in this repository. They are downloaded into
your own Codespace at setup and disappear with it. Please don't redistribute
them. Papers remain © the American Society for Engineering Education and
their respective authors.

Your Codespace is yours alone — no one else can see it. **Please delete it at
<https://github.com/codespaces> when you are finished with it.** ASEE's
permission covers this session, so retiring the environment afterwards is part
of the agreement we made to be able to use the papers at all. Save anything you
want to keep first — your report, your brief, your notes.

---

## Trouble?

| What you see | What to do |
|---|---|
| The **Code** button only offers to clone or download | You're on the **Local** tab. Click the **Codespaces** tab beside it. |
| "Do you trust the authors of the files in this folder?" | Click **Yes, I trust the authors**. These are this repository's own files. |
| Chrome asks to see your clipboard | Click **Allow** — that's how the paste reaches the terminal. |
| The terminal warns you about pasting | Choose the option that pastes anyway. |
| Nothing appears when you paste the code | Expected. The code is hidden on purpose. Press Enter; the script then tells you how many characters it received. |
| You closed the terminal | **Terminal → New Terminal**, or <kbd>Ctrl</kbd>+<kbd>`</kbd>. |
| `bash: setup.sh: No such file or directory` | You're in the wrong folder. Run `cd /workspaces/asee-mw-2026-agentic-ai-workshop` and try again. |
| "That code was not accepted" | A character is missing or a space slipped in. The script asks again in place — just enter it once more. |
| `openclaw: command not found` | Run `bash setup.sh`. It installs the agent itself if the container didn't. |
| Codespace won't start | At <https://github.com/codespaces>, delete only an earlier Codespace made from **this** repository (asee-mw-2026-agentic-ai-workshop), then create a new one. Leave any other Codespaces alone. |
| Anything else | Raise a hand. |

---

## License

Workshop materials in this repository are released under the MIT License
(see `LICENSE`). **This does not apply to the ASEE PEER papers**, which are
separately licensed and not distributed here.
