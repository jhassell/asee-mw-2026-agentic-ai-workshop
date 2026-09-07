# Pass 3: check before you believe

This is a guided investigation: the two checks are given, what they find
is yours to discover and yours to write down.

The rule for this pass: **do not ask the agent whether the agent was
right.** Check the world instead.

First, get a terminal that is not the agent. In the menu bar choose
**Terminal > New Terminal**. A second panel opens with a `$` prompt. Type
here, not at the agent.

## Move 1: inside the sandbox

Copy, paste, Enter:

```
grep -ah '^title:' corpus/papers/*.md | sort | uniq -d
```

If two files share a title, one title prints. Find the two files:

```
grep -al "PASTE THE TITLE HERE" corpus/papers/*.md
```

Open both. Compare the `paper_id` at the top with the "Paper ID" line in
the body. Now look at your `coverage-report.md`: how many papers did it
count, and are both of these files in the same theme?

## Move 2: outside the sandbox

Look at section 4 of your report, "Claims worth verifying." Take the paper
ranked first, the one you would cite tomorrow. Copy its title. In a new
browser tab, go to <https://peer.asee.org> and search for that title. Then
search for the first author's name. Then do the same for the paper ranked
second, so you have a comparison.

Three different things, and only the first two are checks you can run here:

- Finding a quotation in the file shows the paper *says* it.
- Finding the paper on PEER shows the paper *exists*.
- Neither shows the conclusion is *well supported*. Big numbers in an
  abstract are a reason to read the methods, not a reason to trust them.

If a search finds nothing, write "not verified," not "fake." A search can
miss a real paper. What makes a paper fake is evidence, and you will hear
some in a moment.

Write on your exit card, lines 2 and 3: the claim you checked and what you
found; and what your report now has to say instead.

## When the facilitator says so: correct the folder

Never build anything else on a folder you know is contaminated. In the
plain terminal, remove the files the room has just agreed are defective,
using their real filenames, then count again:

```
rm corpus/papers/<first-id>.md corpus/papers/<second-id>.md
ls corpus/papers | wc -l
```

Write the new count on your card. Anything in your report that depended on
the removed files has to be re-derived or withdrawn.

## If this went wrong

- Move 1 printed nothing: you typed at the agent prompt. Open a new
  terminal (Terminal > New Terminal) and try again.
- You do not know which paper your report ranked first: open
  `coverage-report.md` and read section 4.
- peer.asee.org is slow on the conference wifi: try
  <https://scholar.google.com> with the title in quotes.
