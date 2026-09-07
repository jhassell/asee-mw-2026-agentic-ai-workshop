# Rubric template

**Takeaway (c) of four.** Yours to edit. It pairs with `starter-assignment.md`
and grades what that assignment asks a student to hand in: a working artifact,
plus the record of how they directed and checked the agent that helped build
it. Adapted from **SDI 4243/5243 Agentic Systems** (OU Polytechnic Institute,
Summer 2026). Two mechanisms carry most of the weight and both are free to
adopt: a prompt changelog (`PROMPTS.md`) and a build journal graded on honesty
about failure (`JOURNAL.md`).

**The thesis:** a flawless demonstration with no failure narrative is an
incomplete demonstration. Working code proves the student got an output. The
specification, the verification, and the failure account prove they could get
it again, catch it when it goes wrong, and say what happened. The artifact is
worth 15 points here; the process is worth 85.

---

## The grid

Four levels. **Exemplary 100% · Proficient 80% · Developing 55% · Not yet 0%**
of the criterion's points. Grade each row independently.

| Criterion | Pts | Exemplary | Proficient | Developing | Not yet |
|---|---|---|---|---|---|
| **1. Specification**<br>The instructions given to the agent | 20 | The final prompt states scope (what is in and out), output format, and at least two acceptance criteria the agent can fail. A stopping rule is present. A stranger could re-run it and get a comparable result. | Scope and format are explicit. Acceptance criteria are present but vague ("be accurate") or unfalsifiable. | The prompt names a task and little else. Scope is implied. No criteria the agent could be judged against. | No prompt submitted, or one vague sentence with no scope, format, or criteria. |
| **2. Verification**<br>Evidence the student checked the agent, not the agent's report | 25 | Every factual claim is traced to something the student inspected directly — a file, a command output, a page, a number they recomputed — and the submission *shows* the check (command, screenshot, quoted source) rather than describing it. It identifies at least one mistake the assistant made and how it was caught. | Verification is real but partial: key claims checked, some taken on the agent's word. Checks described rather than shown. | Verification is asserted ("I confirmed the output was correct") with no method and no artifact. | None. The agent's report is reproduced as the finding. |
| **3. Failure account**<br>`JOURNAL.md` — completeness and honesty | 25 | Every required entry present, four to eight sentences each, covering what was built, what failed, what changed, and where AI helped and how its output was verified. Each names a **specific** failure — the actual error, wrong output, or wrong assumption — and points at something a grader can open: a commit, a diff, a file, a log line. Reads like a lab notebook. | All entries present, four to eight sentences, specific enough to follow, but at least one failure is described generically ("it kept breaking") or cannot be checked against the repository. | Entries present but thin, retrospective, or sanitized: process narration with no identified failure. Or fewer than half the required entries. | Missing, or a success story with no failures reported. |
| **4. Prompt changelog**<br>`PROMPTS.md` | 15 | An entry for every substantive prompt change, each stating **what changed, what was expected, and what was observed**. The observed effect is sometimes "no improvement" or "worse." Prompt versions are recoverable from the repo. | Entries for most changes, stating what changed and why, but the observed effect is missing or asserted without evidence. | A few entries, or entries saying only that the prompt was improved. | No changelog, or prompts exist nowhere in version control. |
| **5. Artifact**<br>The thing that was built | 15 | Runs as specified from a clean checkout. Meets the stated requirements. Known limitations documented rather than hidden. | Runs with minor deviations from spec, or requires an undocumented step. | Runs partially, or only in the student's own environment. | Does not run, or was not submitted. |

**Total: 100 points.**

### Two grader rules that do the real work

- **The unverifiable-claim cap.** If the submission states as fact anything the
  student could not have checked — a source that does not exist, a number that
  appears nowhere in the cited material, a result from a run that never
  happened — criterion 2 is capped at **Developing**, however good the rest is.
  An agent's report of its own success is evidence of nothing: check the
  artifact, not the narration.
- **The evidence spot-check.** Before scoring criterion 3, pick **one** claimed
  failure at random and go look for it in the repository. If the commit, diff,
  or file it points at is not there, drop that row one level and say why. It
  takes about ninety seconds and it is the difference between grading honesty
  and grading the performance of honesty.

Grade rows 3 and 4 from the repository *before* you open the artifact.
Otherwise everything after "it works" reads as justification.

---

## Adapting the weights

The five criteria are the durable part; the numbers are a starting position.
Move them deliberately — the weights are the message students actually read.

- **A course that is not about AI at all:** keep criteria **1, 2, and 4**
  (20/25/15, rescaled) and attach them to any assignment where students use an
  assistant. Cheapest version to adopt; needs no tooling beyond a repository,
  or a shared document.
- **Capstone or senior design:** raise **Failure account** to 35 and add a
  sixth row for *recovery* — can the student roll the system back to a
  known-good state and narrate it?
- **Large sections:** cut to three rows (Specification, Verification, Failure
  account) at 40/30/30 and grade the artifact pass/fail separately. The
  spot-check matters more, not less, as section size grows.
- **What not to move:** do not let **Artifact** exceed **Specification** plus
  **Verification**. Past that you are rewarding output again, and students will
  optimize for a clean demo by hiding the interesting parts.

---

## What this rubric does about academic integrity

It replaces detection with disclosure. One of the journal's four required
fields is *where AI helped and how you verified its output*, so the journal is
itself the AI-use disclosure record: declaring assistance is not a confession
but a graded deliverable, and omitting it costs points on criterion 3. The
misconduct line therefore is not "you used an agent" — it is **"you presented
an unverified claim as a finding, or you concealed how the work was
produced."** Both are checkable against the repository, the changelog, and the
artifact. Authorship detection is not. This turns integrity from a policing
problem into a professional disclosure habit, and it produces the audit trail
engineering teams now expect.

**Honest caveat.** This rubric is unvalidated — one four-week offering, a small
cohort, a single instructor, and no evidence yet that it rewards candor rather
than a performance of candor. The spot-check is the structural
counter-measure, not a proof. Anchor the failure descriptors to your own
artifacts and expect to revise after your first real stack of submissions.
