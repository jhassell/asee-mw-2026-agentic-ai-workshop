# Your idea

Point the same agent at your own work.

**First, pick the screen you will use.** If your own Codespace reached
READY, use it now, and run the correction there too: in its plain
terminal, `ls corpus/papers | wc -l` must show the corrected count before
you go on. If yours never reached READY, stay with your partner and you
type this one. Two people on one screen run the prompt twice, one after
the other. The second person changes `my-positioning.md` to
`my-positioning-2.md` in the prompt before pasting (it appears once), so
the first brief is not overwritten. Each of you leaves with your own file.

**Before you paste:** your text goes to a third-party model over the
internet. Paste only what you would put in a public abstract. No student
data, no unpublished results you are not ready to share.

Fill in the bracket, then copy everything between the lines, paste it at
the agent prompt (the first terminal), and press Enter.

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

Open your brief (`my-positioning.md`, or `my-positioning-2.md` if you
ran second). Then two checks, both required:

1. Pick one of the five papers. Open it in `corpus/papers/` and find the
   quoted sentence. Is it there, and does it say what the brief claims?
2. Search that paper's title on <https://peer.asee.org>. Is it real?

Check 2 would have failed for the file you removed. The habit is to run
it anyway. A miss means "not verified," not "fake."

If the facilitator says there is time for only one check, do check 1 now,
write *provisional* on the first line of your brief, and do check 2 before
you use the brief for anything.

Take a photo of your card, or copy your brief somewhere you own, before
the session ends.

Be ready to answer, in one sentence: what did the corpus tell you that you
did not know, and did the quotation hold up?

## To take home

Your brief, and this prompt. The prompt names no paper count and no
corpus, so it works unchanged on any folder of Markdown or text documents
you have the right to use; it reads the files themselves. The pass-2 coverage spec is different: it expects each file to
have YAML frontmatter with `paper_id`, `title`, and `key_terms`, and an
`## Abstract` heading. On your own documents, rewrite its first sentence to
describe what your files actually contain. What either prompt produces is a
quick map, not a literature review; treat section 3 as a lead to check, not
a finding.
