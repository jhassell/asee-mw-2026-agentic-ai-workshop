# Pass 2: ask well

Same task. Now with the three things the room just asked for: what exactly
to look at, what shape the answer takes, and how we will know it is right.

**Write criterion 5 before you paste.** It is the one line in this file that
is yours. Take it from what the room said it would need in order to trust
the answer. Copy it onto your exit card too.

Copy everything between the lines, fill in criterion 5, paste it at the
agent prompt, and press Enter.

```
Read the YAML frontmatter (paper_id, title, key_terms) of every file in
corpus/papers/. Do not read the full text of every paper; write a short
Python script that reads the frontmatter instead. Group the papers into
8 to 12 themes based on title and key_terms. Then write
coverage-report.md containing:
  1. A table with one row per theme: theme name, paper count, and the
     list of paper_ids in that theme.
  2. The three most-covered themes, with one sentence each on what they
     have in common.
  3. Three themes you would expect to find in an AI-in-engineering-
     education track that have 0 to 2 papers IN THIS CORPUS. For each,
     cite the ONE paper in the corpus that comes closest: paper_id and
     title. Say "thin in this corpus," never "missing from the
     literature" — 79 selected papers are not the literature.
  4. "Claims worth verifying": read ONLY the "## Abstract" section of
     each file (extend your script; do not read full papers) and list the
     three papers that make the strongest quantitative claims about
     student outcomes: a controlled or comparative design, a sample size,
     an effect size or a percentage change. For each: paper_id, title,
     the design in five words, the key number. Rank them by how much you
     would want to verify before citing, first = most.
Also save coverage.png, a horizontal bar chart of papers per theme, using
matplotlib.
Acceptance criteria:
  (1) every paper_id appears in exactly one theme;
  (2) the counts in the table sum to the number of files in the folder;
  (3) every paper_id you cite exists as a file in corpus/papers/;
  (4) every number you quote in section 4 appears in that paper's abstract;
  (5) [WRITE YOUR OWN CRITERION HERE]
```

## While it runs, you are the supervisor

Three things to watch for, and what to type at the agent prompt:

| You see | You type |
|---|---|
| It starts opening full papers one after another | `Stop. Frontmatter for the themes, the Abstract section only for section 4, as the spec says.` |
| It asks you a question | Answer it in one line. |
| It says it is done but there is no `coverage.png` | `The chart is missing. Finish the spec.` |
| Nothing has scrolled for two minutes | Raise a hand. |

You will see it write a script, run it, maybe fix an error, and run it
again. That loop is what "agent" means.

## When it finishes

Open `coverage-report.md` and `coverage.png` in the editor (click them in the
file list on the left).

Then look at the spec again. Which words changed a paragraph into a table?
Was your criterion 5 met? Underline the words that did the work.

One thing to notice about section 3 while you are there: the agent can tell you
what is thin in *this folder*. It cannot tell you what is missing from your
field, and neither can you without a search method you could defend. If your
report slid from one to the other, that is the same overclaim we are here to
catch — made by you this time, not by the agent.

## If this went wrong

- It wrote the report but no chart: paste `Now save coverage.png as
  described` and press Enter.
- It says matplotlib is missing: paste `pip install matplotlib, then
  continue` and press Enter.
- It is still running at the ten-minute mark: raise a hand and look at your
  neighbor's report instead. Pass 3 works on any report.
