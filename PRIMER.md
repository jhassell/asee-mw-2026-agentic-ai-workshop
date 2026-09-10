# What you are actually using

### A ten-minute primer for Workshop 9, "From Chatbots to Agents"

You do not need this to do the exercises. Read it if you want to know what the
thing on your screen actually is, because the vocabulary is about eighteen
months old and most of it was invented by people who were building faster than
they were naming.

You are an engineer. You are used to being handed equipment whose insides
someone can explain. This is that explanation.

---

## 1. What is an agent?

Start with the honest part: **there is no settled definition, and the people
closest to the work disagree.** "Agency" is doing a lot of philosophical labour
in a word that vendors also use for marketing. If you leave today unsure
exactly where the boundary is, you are in the same position as the researchers.

But we can be precise about what it is **not**.

A **chatbot** is a turn-taking text machine. You type. It replies. You read the
reply, decide what you want next, and type again. Between your turns, *nothing
happens*. The only thing in the world that changed is some text on a screen.
Every action — opening the file, running the command, checking the result,
deciding what to try next — is performed by you. The model is an advisor that
cannot touch anything.

An **agent** is given a goal instead of a question, and then it acts in a loop:

> decide what to do next → do it → look at what happened → decide again

It reads files you did not open. It runs commands you did not type. It notices
that its own script crashed and fixes it. You will watch this happen today, and
the moment it becomes obvious is the moment it writes a program, runs it, hits
an error, and repairs it without asking you.

**The useful test, if you want one line to take away:**

> *Does anything change while I am not typing?*
> If the only thing that changes is text on a screen, it is a chatbot.
> If files appear, commands run, a chart gets drawn — that is an agent.

## 2. What is an agentic system?

Not just the model. The whole assembly:

| Part | What it is |
|---|---|
| **The model** | The thing that reads context and decides what to do next. It has no hands. |
| **Tools** | The hands. Read a file, write a file, run a command, search the web. |
| **A place to act** | A computer, a folder, a sandbox — somewhere the actions land. |
| **Memory** | What it carries between steps, and what it forgets. |
| **The loop** | The machinery that runs decide → act → observe, over and over, and decides when to stop. |
| **Guardrails** | What it is not permitted to do, and what needs your approval first. |

Everything in that table except the first row is **not the model**. Which
brings us to the word that has finally settled this year.

## 3. The harness — and why this may be a new engineering discipline

The field converged during 2026 on a formulation worth memorising:

> ## Agent = Model + Harness

The **harness** is everything that is not the model. It is the tool dispatch,
the memory, the sandbox, the permissions, the retry logic, the loop itself. A
raw model cannot do anything. Give it a harness and it becomes an agent.

This matters more than it sounds, and here is the part worth sitting with:

**A harness hands a model the keys to a computer.** That is not a metaphor. The
harness is what lets a language model open your files, run programs as you, and
change things that stay changed. It is what turns a computer from a thing you
operate into something that acts on your behalf — your agent, in the older and
more literal sense of that word, the sense a lawyer would recognise.

That is an enormous amount of power to delegate, and the engineering that
decides *how much*, *within what boundary*, *with what approval*, and *with
what record* is real engineering. It has requirements, failure modes, and safety
cases.

### You can watch this discipline being named

This should interest an engineer, because the naming happened close enough to
now that the seams are still visible.

The nouns *agent harness* and *LLM harness* circulated among practitioners
before anybody named the practice. The phrase **harness engineering** appears in
early 2026, and **who coined it is genuinely contested** — some accounts trace
it to a February 2026 post by Mitchell Hashimoto, describing the practice of
engineering a permanent fix into an agent's environment every time it makes a
mistake; others credit Vivek Trivedy at LangChain, whose "Anatomy of an Agent
Harness" derived the components from the `Agent = Model + Harness` formula.

By mid-2026 it had become an object of academic study — including work on
agents that mine their own failures to propose improvements to their own
harness — and it now has reference-work and vendor documentation (Microsoft,
Databricks, LangChain, O'Reilly) where eighteen months ago it had none.

**So the claim is not that this is a discipline nobody has noticed.** It is that
a discipline acquired its name, its literature, and its first attempts at a
textbook inside about nine months — and that you are about to spend an hour
inside one of the first widely used harnesses. Not a mature tool with thirty
years of accumulated practice. An early one, in a field whose vocabulary settled
after most of us last updated a syllabus.

### Why this is the intellectual centre of the workshop, not background

The harness decides what the agent **can possibly know**.

An agent working inside a folder can tell you what the folder says. It cannot
tell you whether the folder is telling the truth, because nothing inside the
boundary of its harness can answer that question. That is not the model being
stupid. It is a harness boundary, and no amount of better prompting crosses it.

Which is why the third exercise today sends you *outside* the box to check.
Verification is not a good habit bolted onto agent use. It is the direct
consequence of the fact that a harness has edges.

## 4. What is GitHub? What is a Codespace?

Plain terms, no jargon.

**GitHub** is a website that stores folders of files, along with a complete
record of every change ever made to them — who changed what, when, and why. The
version-control system underneath is called *git*, and the reason engineers care
is that it makes changes reversible and attributable. Around that, GitHub adds
the social machinery: copies of projects, proposed changes, review, discussion.
For today you need exactly one thing from it: a free account.

**A Codespace** is a computer that GitHub builds for you in the cloud and shows
you inside a browser tab. It comes with an editor, a terminal, and whatever
software the project's owner specified in advance. It exists for as long as you
want it and then you delete it.

Three reasons this workshop uses one:

1. **You install nothing.** No Python, no Node, no keys, no conflicts with
   whatever is already on your laptop.
2. **Everyone is identical.** Twenty-four people, one environment. When
   something breaks it breaks the same way for everybody, which is the only
   reason a room this size is possible in eighty minutes.
3. **It is disposable.** An agent with the keys to a computer should be given a
   computer you are willing to throw away. That is a harness-engineering
   decision, and it is the same reason you would test a new controller on a rig
   rather than on the production line.

## 5. What is OpenClaw?

OpenClaw is a harness. It runs in the terminal, you start it with
`openclaw chat`, and it connects a model to a set of tools and a working folder
— your Codespace.

It is **new**. Its package first appeared publicly on **29 January 2026**, and
it has shipped **253 releases** in the seven months since. That is not a
criticism; it is the tempo of the field. It is also not abstract for us: a
release published on **8 September 2026** — the morning before this material was
finalised — raised a requirement in a way that broke this workshop's setup
outright, and had to be found and pinned. Your environment is deliberately
frozen to one tested version for that reason.

You are, genuinely, using early equipment.

### How it relates to Claude and to ChatGPT

The distinction that clears up most confusion:

- **A model** is Claude, or GPT, or Gemini. Anthropic, OpenAI and Google build
  models.
- **A harness** is Claude Code, Codex CLI, OpenClaw. It is the equipment
  *around* a model.

Those are different products, and they mix. Anthropic ships its own harness
(Claude Code) around its own models. OpenAI ships Codex. OpenClaw is an
independent harness that can be pointed at somebody else's model — today it is
pointed at a Gemini-family model through a service called OpenRouter, which is
simply a switchboard that lets one piece of software reach many providers.

So when you hear that Claude or ChatGPT has "agentic capabilities," this is what
that means: the vendor has built and now ships the harness themselves, rather
than leaving you to assemble one. Same architecture. Different supplier.

## 6. A short timeline

Dates for the vendor tools come from their announcements; the OpenClaw dates
come from the public package registry and are checkable.

| When | What |
|---|---|
| **Feb 2025** | Claude Code, research preview — the agentic loop in a terminal, at scale, for the first time in wide use |
| **Apr 2025** | OpenAI Codex CLI |
| **May 2025** | Claude Code generally available |
| **Jun 2025** | Google Gemini CLI |
| **Jan 2026** | **OpenClaw's first public release** |
| **Feb 2026** | The phrase "harness engineering" starts appearing. Attribution is contested to this day |
| **19 May 2026** | Google announces it is retiring Gemini CLI |
| **18 Jun 2026** | Gemini CLI stops serving individual accounts; Antigravity CLI replaces it — none of this is stable yet |
| **mid-2026** | Harnesses become an object of academic study, including agents that improve their own harness |
| **Sep 2026** | An OpenClaw release breaks this workshop's container. You are reading a pinned version because of it |

Eighteen months, start to finish. Most of the engineering practice around these
tools has not been written yet. Some of it will be written by people in this
room.

## 7. Where this goes next

This part is argument, not fact. Treat it as such.

Right now a harness gives a model the keys to a **computer**: files, programs,
a network connection. The interesting question is what happens when the same
pattern is applied to things that are not computers.

A harness is, structurally, an interface between a decision-maker and a world it
can act on, plus the guardrails that make that safe. Nothing about that is
specific to files and shell commands. Point it at instruments, a test cell, a
vehicle, a building's systems, a fabrication line, a field robot, and you have
the same architecture with different hands — a harness for physical and spatial
systems.

If that is right, then the engineering questions get very familiar very fast:
what is the actuation boundary, what requires human authorisation, what is
logged, how do you verify a claimed action actually happened, and how does the
thing fail safe. Those are questions engineers already know how to ask. They are
questions this room is better equipped to ask than most.

Which is the real reason the workshop spends its time on specification,
supervision and verification rather than on prompt tricks. The tricks are
specific to this year's tools. The habits transfer to whatever the harness is
attached to next.

---

## The short version

- Nobody has a clean definition of "agent," including the experts.
- It is definitely **not** a chatbot: with a chatbot, nothing happens between
  your turns.
- **Agent = Model + Harness.** The harness is everything that is not the model.
- A harness hands a model the keys to a computer, which is why the boundary,
  the permissions and the record matter.
- **GitHub** stores files with their history. A **Codespace** is a disposable
  computer in a browser tab.
- **OpenClaw** is a harness, seven months old, and you are using early
  equipment on purpose.
- A harness has **edges**, and the agent cannot see past them. That is why you
  verify outside the box — which is exercise three.
