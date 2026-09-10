# What you are actually using

### A ten-minute primer for Workshop 9, "From Chatbots to Agents"

You do not need this to do the exercises. Read it if you want to know what the
thing on your screen actually is.

You are an engineer. You are used to being handed equipment whose insides
someone can explain. This is that explanation. Some of the vocabulary is recent
and still unsettled; **no prior familiarity is assumed**, and where the field is
still arguing, this primer says so rather than picking a winner and pretending.

---

## 1. What is an agent?

There is **no single accepted boundary** around the word. Vendors, researchers
and practitioners draw it in different places, and the disagreement is real
rather than a failure of anyone's homework.

So rather than pretend otherwise, here is the **operational definition this
workshop will use**:

> **An agent is a model that can choose an action, use a tool, observe the
> result, and decide what to do next — without waiting for another instruction
> from you.**

That is a definition you can hold a system against, which is what an
engineering definition is for.

### How it differs from a chatbot

The familiar experience is turn-taking: you type, it replies, you read, you
decide, you type again. Every decision about *what to do next* is yours. The
model is an advisor that cannot act.

An agent is given a goal instead of a question, and then runs a loop:

> decide what to do next → do it → look at what happened → decide again

**The clearest way to recognise one** is not where the text appears — it is this
specific behaviour, which you will see today:

> *The system chooses a command, runs it, sees it fail, changes its approach,
> and runs something else — without you telling it to.*

That moment is unmistakable, and a chatbot cannot do it.

A caution about easy tests, since this workshop is about not being fooled:
"does it produce text, or files?" will not separate them. A chat interface can
run code and write files behind the scenes; an agent can work for two minutes
and hand you nothing but a paragraph. **Chat is an interface. Agency is a
behaviour.** Judge the behaviour.

## 2. What is an agentic system?

Not just the model. The whole assembly:

| Part | What it is |
|---|---|
| **The model** | Reads context, decides what to do next. It has no hands. |
| **Tools** | The hands. Read a file, write a file, run a command, search. |
| **An environment** | A computer, a folder, a sandbox — where the actions land. |
| **State / memory** | What it carries between steps, and what it forgets. |
| **The loop** | Runs decide → act → observe repeatedly, and decides when to stop. |
| **Permissions and oversight** | What it may not do, and what needs your approval. |

Everything except the first row is **not the model**.

## 3. The harness

A useful shorthand — **our working model for today**, not a standard anyone is
obliged to accept:

> ## Agent ≈ Model + Harness

The **harness** is the engineered runtime around the model: the tools it can
call, the environment it acts in, the evidence it can reach, the state it keeps,
the loop, the permissions and the oversight. A raw model does nothing at all. A
harness is what makes it an agent.

(The word gets used at two scales — broadly, "everything that is not the model,"
and narrowly, inside some systems, for the component that executes one prepared
turn. This primer means the broad sense.)

### The delegation problem

Here, the harness gives the model **tool-mediated access to a computer**: within
the permissions we grant, it can read files, write files and run commands, and
what it changes stays changed.

That is a real transfer of authority, and it is what makes a computer into
something that acts on your behalf. So:

> **The engineering problem is deciding which keys it gets.**

Which unpacks into questions this audience already knows how to ask:

- What **authority** does it have?
- Within what **boundary**?
- What requires **human approval**?
- What **record** does it leave?

That is requirements, threat modelling, failure modes, containment and
auditability. It is engineering — and it is the part with the least accumulated
practice.

### A discipline being named, in public, right now

This should interest an engineer, because the seams are still visible.

The nouns *agent harness* and *LLM harness* circulated among practitioners
before anyone named the practice. **Mitchell Hashimoto used the phrase "harness
engineering" on 5 February 2026**, describing the habit of engineering a
permanent fix into an agent's environment each time it makes a mistake.
**LangChain published "Anatomy of an Agent Harness" on 10 March 2026**, which is
where the broad `Agent = Model + Harness` shorthand comes from — a different
contribution, not a rival claim to the same one. By **June 2026** researchers
were explicitly asking what makes a harness a harness.

So the honest description is **an emerging engineering practice** — a candidate
discipline that acquired a name, a literature and its first arguments inside
about nine months. Not an established field. Not one nobody has noticed, either.

You are about to spend an hour inside one of the first widely used harnesses.

### Why this is the centre of the workshop, not background

Here is the principle, stated carefully, because the sloppy version is wrong:

> ## A harness bounds the evidence available to the agent.

Not what it *knows* — a model knows a great deal from training, can infer, and
can spot a contradiction placed in front of it. What the harness bounds is
**which evidence the agent can obtain, and which actions it can take, during
this task.**

Inside a closed folder, an agent can tell you what the folder says, and whether
the folder contradicts itself. It **cannot independently establish an external
fact that requires evidence it cannot reach.** That is not the model being
stupid, and better prompting does not fix it, because prompting cannot
manufacture a source the system cannot access.

Which gives the rule the whole workshop is built on:

> **Verification requires an evidence path independent of the one that produced
> the claim.**

Note what that does *not* say. It does not say verification must happen outside
the harness — you could give a harness its own independent lookup and let it
verify internally. **Today we deliberately put that path outside the sandbox and
in your hands,** because the point is for *you* to cross the boundary and feel
where it is.

## 4. What is GitHub? What is a Codespace?

**GitHub** stores project files along with a version history of committed
changes. The system underneath is called *git*. What engineers get from it is
that changes are attributable and reversible. Two honest caveats: history *can*
be rewritten, and a change records *why* only insofar as somebody wrote a useful
message. Today you need one thing from it — a free account.

**A Codespace** is a disposable cloud development environment: a computer GitHub
builds for you and shows you in a browser tab, with an editor, a terminal, and
whatever software the project specified in advance. You can stop and restart it,
and inactive ones are deleted automatically after a retention period (30 days by
default). **We will delete ours deliberately when we finish.**

Three reasons this workshop uses one:

1. **You install nothing** on your laptop.
2. **Everyone is identical.** Twenty-four people, one environment — the only
   reason a room this size works in eighty minutes.
3. **It is disposable.** Something given tool-mediated access to a computer
   should be given a computer you are willing to throw away. Same instinct as
   commissioning a new controller on a rig rather than on the line.

## 5. What is OpenClaw?

OpenClaw is a harness. It runs in the terminal, you start it with
`openclaw chat`, and it connects a model to a set of tools and a working folder.

Checkable facts rather than impressions: its public repository dates from
**24 November 2025**, with tagged releases the next day. The `openclaw` package
was published to the public registry at the end of **January 2026**, and the
registry currently lists **253 published versions in total**, prereleases
included.

Worth noticing if you go and look: **the project is older than the name it
carries.** The repository predates the `openclaw` organisation it now lives in,
and the January release renamed work already under way. Things here get built,
renamed and re-homed faster than anyone documents them.

It is not abstract for us either. A release published on **8 September 2026** —
the day before this material was finalised — raised the required version of an
underlying runtime and broke this workshop's setup outright. It had to be found,
diagnosed and pinned. Your environment is frozen to one tested version because
of it, and you will never see the failure. **That is a harness-engineering
decision too.**

### Model or harness? — why the vendor announcements are confusing

- **Models** are Claude, GPT, Gemini. Anthropic, OpenAI and Google build these.
- **Harnesses** are Claude Code, Codex CLI, OpenClaw — equipment *around* a model.

They mix. Anthropic ships a harness around its own models; OpenAI ships Codex;
OpenClaw is independent and can be pointed at somebody else's model. Today it is
pointed at a Gemini-family model through OpenRouter, a switchboard that lets one
program reach many providers.

So when a vendor says its product "now has agentic capabilities," it means
**they now ship the harness too**, instead of leaving you to assemble one. Same
architecture. Different supplier.

## 6. A short timeline

| When | What |
|---|---|
| **24 Feb 2025** | Claude Code, limited research preview |
| **16 Apr 2025** | OpenAI Codex CLI |
| **22 May 2025** | Claude Code generally available |
| **25 Jun 2025** | Google Gemini CLI |
| **24 Nov 2025** | The repository that becomes OpenClaw appears |
| **late Jan 2026** | The `openclaw` package is published, renaming existing work |
| **5 Feb 2026** | "Harness engineering" used as a phrase |
| **10 Mar 2026** | `Agent = Model + Harness` published as a shorthand |
| **19 May 2026** | Google announces the move to Antigravity CLI |
| **18 Jun 2026** | Gemini CLI ends for consumer Google accounts; enterprise and API-key access continue |
| **Jun 2026** | Researchers begin asking what makes a harness a harness |
| **8 Sep 2026** | An OpenClaw release breaks this workshop |

Most of the engineering practice around these tools has not been written yet.

## 7. Where this might go — and what it is not

*This section is argument, not fact.*

Today a harness mediates a model's access to a computer. The interesting
question is what happens as the same pattern reaches instruments, vehicles,
buildings, fabrication lines and field robots. Anthropic has begun describing a
standard intended to let agents operate physical devices, so the direction is
not fantasy.

**But be careful with the analogy — this room more than most will notice if I am
not.** Physical systems are not "the same architecture with different hands."
They add real-time constraints, continuous dynamics, sensor uncertainty,
actuator limits, interlocks, irreversible consequences, certification regimes,
stability and fault tolerance. Robotics, controls and safety engineering have
**mature theory** for problems agent developers are only beginning to meet.
Nobody has rediscovered control systems and renamed them.

What is genuinely interesting is that the same *questions* recur — authority,
actuation limits, observability, verification, safe failure — and that the
people who already know how to answer them for physical systems are mostly not
the people currently building agent harnesses.

Several of them are in this room.

---

## The short version

- There is no agreed definition of "agent." Ours for today: it chooses an
  action, uses a tool, observes the result, and continues without waiting for
  you.
- You will recognise it when it **runs something, sees it fail, and tries
  something else on its own.**
- Working model: **Agent ≈ Model + Harness.** The harness is the engineered
  runtime — tools, environment, evidence, state, loop, permissions.
- The engineering problem is **deciding which keys it gets**: what authority,
  what boundary, whose approval, what record.
- **A harness bounds the evidence available to the agent.** Prompting cannot
  manufacture a source the system cannot reach.
- Therefore **verification requires an evidence path independent of the one that
  produced the claim** — which is exercise three.
