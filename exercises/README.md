# The exercises

One task, done three ways. Then one change to a course you teach.

That is the whole session. It is deliberately short — you are here to build a
habit, not to get through a list.

**The task:** "Which topics does this set of papers cover heavily, and which
are thin? Show me."

**The papers:** 79 conference papers in `corpus/papers/`, from the 2026 ASEE
Annual Conference AI and data-science track. ASEE provided them for this
session only. Do not copy them out of this environment.

Before you start, `bash setup.sh` must have printed **READY**, and
`ls corpus/papers | wc -l` must say **79**.

## Files, in order

| | File | What you do |
|---|---|---|
| 1 | [`pass-1-underspecified.md`](pass-1-underspecified.md) | Ask badly. See what you get. |
| 2 | [`pass-2-specified.md`](pass-2-specified.md) | Ask well, with one criterion you wrote yourself. Supervise while it runs. |
| 3 | [`pass-3-verify.md`](pass-3-verify.md) | Check before you believe. Then correct the folder. |
| 4 | [`adapt-one-line.md`](adapt-one-line.md) | Write one change to one assignment, and the rubric line that grades it. |

## To take home

Not part of the session. These are yours to use afterwards, and the first one
is the one to do first.

| File | What it is |
|---|---|
| [`your-idea.md`](your-idea.md) | **Do this one first — today, before you delete your Codespace.** Point the same agent at your own abstract or course, get a positioning brief back, then check it. It needs the paper corpus, which goes away with the Codespace. Ten minutes. |
| [`keep-it-running.md`](keep-it-running.md) | How to keep this environment working after today, with your own key, for about ten dollars. |
| [`starter-assignment.md`](starter-assignment.md) | A one-week assignment you can adapt: delegate, verify, document. |
| [`rubric-template.md`](rubric-template.md) | The grading grid that goes with it. Five criteria, four levels. |
| `what-went-wrong.md` | The candid list from our Summer 2026 course. |

## If you fall behind

Skip to whichever file the room is on. Every file works on its own, except
that pass 3 reads the report pass 2 wrote. If you have no report, look at
your neighbor's. Falling behind costs you nothing here — pass 3 is the one
that matters, and it works on anyone's report.

## If the words are new

"Agent," "harness," "Codespace," "OpenClaw" — all about eighteen months old, so
being new to them is the normal condition. [`../PRIMER.md`](../PRIMER.md) is a
ten-minute plain-English explanation, and there is a printed short version on
your chair. The one line worth having now: **Agent = Model + Harness.** The
model decides what to do; the harness gives it hands, a place to act, and
limits. A chatbot has no harness, which is why nothing happens between your
turns.

## Two rules that save time

- The agent prompt and the plain terminal are different things. The agent
  prompt is where you paste instructions. The plain terminal (Terminal >
  New Terminal, a `$` prompt) is where you run the checks in pass 3.
- Nothing has scrolled for two minutes: raise a hand.
