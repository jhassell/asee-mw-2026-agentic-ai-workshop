# Your idea — take this one home

**This is not part of the session.** We cut it from the room deliberately: the
three passes are the workshop, and doing them properly matters more than doing
more of them. This is the first thing to do afterwards, and it is the one that
will actually change how you work, because it runs on material you care about.

**Do it before you delete your Codespace — today.** Over lunch, or in a later
session. It takes about ten minutes, and it needs the paper corpus, which goes
away when the Codespace does. ASEE licensed those papers to us for the
conference, so this is the window.

**Before you start**, make sure the corpus is the corrected one: in the plain
terminal, `ls corpus/papers | wc -l` should show the count the room agreed on
after the reveal — not 79. If you never got that far, ask a colleague who
stayed for the reveal which two files to remove, or email hassell@ou.edu.

If you would rather do this later than today: fork the repo and follow
`keep-it-running.md` first, then run this prompt against your *own* documents
instead of the ASEE corpus. The prompt names no paper count, only the folder
`corpus/papers/`, so it works unchanged on any Markdown or text files you have
the right to use and put there. You lose the 79 papers as a comparison set;
you keep everything else.

**Before you paste — read this, it is the one rule in this file.** Your text
goes to a third-party model over the internet, and it leaves your control when
it does. **Use only material you would be comfortable sending to an outside
company.** That means: no student records or student work, no confidential or
unpublished manuscripts, no material you are reviewing for a journal or
conference, no proprietary or industry-restricted data, no unpublished results
you are not ready to share, nothing under NDA or export control.

A published abstract of your own is the safe choice. If nothing you have with
you clears that bar, describe a course you teach in three sentences instead —
that works just as well for this exercise. Teaching this rule to your students
is part of teaching them to use these tools.

In the editor, select the bracketed text below and type over it. Then select
from `Here is a research` to `quotations.` and copy it — not the lines of
three backticks. Click once inside the agent's terminal (the one where you ran
`openclaw chat`; use the terminal list at the right edge of the panel to get
back to it), paste, and press Enter.

```
Here is a research or teaching idea I am considering:

[EITHER paste the abstract of a paper you wrote or are writing, OR type
three sentences about your course or an assignment you want to change.]

Using ONLY the files now in corpus/papers/ (ignore anything you or I
concluded earlier in this conversation, and any earlier report), write
my-positioning.md with:
  1. The five papers closest to this idea. For each: paper_id, title,
     one sentence on how it relates to my idea, and ONE SENTENCE QUOTED
     VERBATIM from the file that supports what you said.
  2. What these papers already establish that I could build on.
  3. What none of the papers in this folder appears to address that my
     idea would add. Say "appears," and say what you based that on.
  4. Three questions a reviewer would ask me that I should be able to
     answer.
If fewer than five papers are relevant, say so. Do not invent papers or
quotations.
```

## When it finishes

Open your brief (`my-positioning.md`). Then two checks, both required — this
is the part that makes it worth doing:

1. Pick one of the five papers. Open it in `corpus/papers/` and find the
   quoted sentence. Is it there, and does it say what the brief claims?
2. Search that paper's title on <https://peer.asee.org>. Is it real?

Run check 2 even when you feel sure. A miss means "not verified," not "fake."

Do both. Nobody is waiting on you now, which is exactly why this version of
the exercise teaches more than the in-room version would have — in the room,
under the clock, the second check was the one that got skipped.

Then answer, for yourself, in one sentence: what did the corpus tell you that
you did not know, and did the quotation hold up?

If it did not — if a quotation was not in the file, or a title returned
nothing — that is the whole workshop happening to you on your own work, which
is the point at which the habit sticks. John would genuinely like to hear about
it: hassell@ou.edu.

## Last: delete the Codespace

Download `my-positioning.md` first (right-click it in the file list, then
**Download**). Then delete the Codespace at <https://github.com/codespaces>:
find the one listed under **jhassell/asee-mw-2026-agentic-ai-workshop**, click
its **…** menu, choose **Delete**. That is the one thing we ask of you, and it
is the condition ASEE set for letting us use the papers at all.

## To take home

Your brief, and this prompt. The prompt names no paper count, only the
folder `corpus/papers/`, so it works unchanged on any Markdown or text
documents you have the right to use and put there; it reads the files
themselves. The pass-2 coverage spec is different: it expects each file to
have YAML frontmatter with `paper_id`, `title`, and `key_terms`, and an
`## Abstract` heading. On your own documents, rewrite its first sentence to
describe what your files actually contain. What either prompt produces is a
quick map, not a literature review; treat section 3 as a lead to check, not
a finding.
