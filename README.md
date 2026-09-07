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
Sign in to GitHub, come back to this page, and click:

> **Code** ▾ → **Codespaces** tab → **Create codespace on main**

A browser-based editor opens. That's it — you can close it again. Doing this
once ahead of time means you walk into the room with a working environment
instead of a signup form.

You do **not** need to install anything on your laptop. You do **not** need
an API key of your own — one is provided at the session.

Bring a laptop that can run a modern browser (Chrome, Edge, Firefox, or
Safari) and that you can type on comfortably for 90 minutes.

---

## At the workshop

You'll receive a **seat card** with a workshop code on it. Then:

1. Open your Codespace (**Code** → **Codespaces** → **Create codespace on main**).
2. In the terminal at the bottom of the window, run:

   ```bash
   bash setup.sh
   ```

3. Paste the code from your seat card when prompted, and press Enter.
4. Wait for **READY**. This takes a few seconds.
5. Start the agent:

   ```bash
   openclaw
   ```

The setup step downloads the workshop paper corpus and configures the agent
for you. If anything fails, it will tell you exactly what to do next — and
raising a hand is always a valid next step.

---

## What we're doing

You'll run one task three times against a corpus of engineering-education
papers, and watch the output change:

1. **Underspecified.** A vague prompt. Plausible, shallow output.
2. **Specified.** The same task with explicit scope, format, and acceptance
   criteria, one of which you write yourself. The difference is visible
   immediately.
3. **Verify.** If you don't check the agent's work against something
   outside the agent, you will confidently report things that aren't true.

Then you point the same agent at your own paper or course, and you write
one change to one assignment you teach. The files are in
[`exercises/`](exercises/).

The takeaway is not "AI is good" or "AI is bad." It's that output quality is
a function of how well you direct and supervise the agent — a habit you can
teach, and a habit your students need.

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

Your Codespace is yours alone — no one else can see it — and you can delete
it at <https://github.com/codespaces> when the session ends.

---

## Trouble?

| What you see | What to do |
|---|---|
| `bash: setup.sh: No such file or directory` | You're in the wrong folder. Run `cd /workspaces/asee-mw-2026-agentic-ai-workshop` and try again. |
| "That workshop code was rejected" | A character is missing or a space slipped in. Re-run `bash setup.sh` and paste again. |
| `openclaw: command not found` | The container is still finishing. Wait 30 seconds, then re-run `bash setup.sh`. |
| Codespace won't start | Delete any old ones at <https://github.com/codespaces>, then create a new one. |
| Anything else | Raise a hand. |

---

## License

Workshop materials in this repository are released under the MIT License
(see `LICENSE`). **This does not apply to the ASEE PEER papers**, which are
separately licensed and not distributed here.
