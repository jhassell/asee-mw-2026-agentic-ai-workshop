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

![Opening a Codespace: click the Codespaces tab, not Local](docs/figures/01-code-menu.svg)

A browser-based editor opens and spends a minute or two building. Along the
way it may ask **"Do you trust the authors of the files in this folder?"** —
click **Yes, I trust the authors** (it is this repository's own files).

![The trust prompt: click Yes, I trust the authors](docs/figures/02-trust-prompt.svg)

That's it — you can close the tab again. Doing this once ahead of time means
you walk into the room with a working environment instead of a signup form.

You do **not** need to install anything on your laptop. You do **not** need
an API key of your own — one is provided at the session.

**Optional, ten minutes, genuinely worth it:** [`PRIMER.md`](PRIMER.md) explains
what you are actually going to be using — what an agent is (and why the experts
still disagree), why it is not a chatbot, what a *harness* is and why that may
be a new engineering discipline, what GitHub and Codespaces and OpenClaw are,
and where all of this appears to be heading. None of this vocabulary is more
than about eighteen months old, so nobody should feel behind. You can also read
it afterwards — there is a printed short version on your chair.

Bring a laptop that can run a modern browser (Chrome, Edge, Firefox, or
Safari) and that you can type on comfortably for 90 minutes.

---

## At the workshop

You'll receive a **seat card**. It has a **6-character code** on the front, and
a long code on the back that does the same job if the short one gives trouble.
Then:

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

![The Codespace layout: explorer, editor, and the terminal where the agent lives](docs/figures/03-codespace-layout.svg)

3. When it asks for the workshop code, type the **6 characters** from the front
   of your seat card and press Enter. Two things are worth knowing:

   - **Nothing appears on the screen as you type.** No dots, no asterisks, no
     movement at all — the code is hidden so it can't be read off your screen.
     It *is* going in, and the script **echoes it back to you** as soon as you
     press Enter so you can check it landed.
   - Case doesn't matter. The codes deliberately avoid every character that
     looks like another one — there is no `O`, `0`, `1`, `I`, `L`, `S`, `Z`,
     `B` or `G` in any of them — and common misreads are forgiven anyway, so a
     `G` typed for a `6` still works.

![Entering the code: nothing appears as you type, then it echoes back](docs/figures/04-entering-your-code.svg)

   If it isn't accepted, the script asks again on the spot; you don't start
   over. If it still won't take, **turn the card over and paste the long code
   instead** — that one works without needing the network to cooperate. If you
   paste it, Chrome may ask to see your clipboard (click **Allow**) and the
   terminal may show its own paste warning (paste anyway).

4. Wait for **READY**. This takes a few seconds.

5. Start the agent:

   ```bash
   openclaw chat
   ```

The setup step downloads the workshop paper corpus and configures the agent
for you. If anything fails, it will tell you exactly what to do next — and
raising a hand is always a valid next step.

---

## What is this stuff?

If "agent," "harness," "Codespace" or "OpenClaw" are new to you, that is the
normal condition, not a gap — the words are about eighteen months old.
[`PRIMER.md`](PRIMER.md) is a ten-minute read that explains all of them in
plain terms, including the honest admission that there is no settled definition
of "agent" even among the people building these things.

The one-line version: **Agent = Model + Harness.** The model decides; the
harness gives it hands, a place to act, and limits. A chatbot has no harness,
which is why nothing happens between your turns.

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

Then you write one change to one assignment you teach, and the rubric line
that grades it. The files are in [`exercises/`](exercises/).

Three passes and one change — that is the whole session. It is short on
purpose. Pointing the agent at your *own* paper or course is the first thing
to do afterwards, and [`exercises/your-idea.md`](exercises/your-idea.md) walks
you through it in about ten minutes.

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

Your Codespace is yours alone — no one else can see it.

**Before you leave, please delete it.** This is the one thing we ask of you.
Your Codespace holds ASEE-licensed papers and a temporary workshop credential,
and ASEE's permission is conditioned on those environments being retired after
the session. Nobody but you can delete it — it lives in your account, not ours.

1. Save anything you want to keep: your report, your brief, your notes.
2. Go to <https://github.com/codespaces>.
3. Delete the one named after **asee-mw-2026-agentic-ai-workshop**, and check
   that it is gone from the list.

![Deleting your Codespace from github.com/codespaces](docs/figures/06-delete-codespace.svg)

Everything you need to build the same environment again with your own key and
your own documents is in `exercises/keep-it-running.md`, and none of it depends
on this Codespace surviving.

---

## Trouble?

| What you see | What to do |
|---|---|
| The **Code** button only offers to clone or download | You're on the **Local** tab. Click the **Codespaces** tab beside it. |
| "Do you trust the authors of the files in this folder?" | Click **Yes, I trust the authors**. These are this repository's own files. |
| Chrome asks to see your clipboard | Click **Allow** — that's how the paste reaches the terminal. |
| The terminal warns you about pasting | Choose the option that pastes anyway. |
| Nothing appears when you type the code | Expected. The code is hidden on purpose. Press Enter and the script echoes it back to you. |
| The 6-character code isn't accepted | Check it against the card, then try again — the script asks again in place. Still no? Turn the card over and paste the long code; it needs no network service. |
| "Could not reach the code service" | Use the long code on the back of the card. |
| You closed the terminal | **Terminal → New Terminal**, or <kbd>Ctrl</kbd>+<kbd>`</kbd>. |
| `bash: setup.sh: No such file or directory` | You're in the wrong folder. Run `cd /workspaces/asee-mw-2026-agentic-ai-workshop` and try again. |
| `openclaw: command not found` | Run `bash setup.sh`. It installs the agent itself if the container didn't. |
| Codespace won't start | At <https://github.com/codespaces>, delete only an earlier Codespace made from **this** repository (asee-mw-2026-agentic-ai-workshop), then create a new one. Leave any other Codespaces alone. |
| Anything else | Raise a hand. |

---

## License

Workshop materials in this repository are released under the MIT License
(see `LICENSE`). **This does not apply to the ASEE PEER papers**, which are
separately licensed and not distributed here.
