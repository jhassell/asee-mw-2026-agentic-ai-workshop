# Pass 1: ask badly

**Where you are:** in the terminal at the bottom of the screen, you have typed
`openclaw chat` and it is waiting for you. That is the agent prompt. If you
have not started it, click in the terminal, type `openclaw chat`, press Enter.

Copy this line, click once inside the terminal, paste it there, press Enter,
and do not help it:

```
What topics do the papers in corpus/papers cover, and what's missing?
```

Watch what it does. It may list the folder. It may open a few files. It may
say it cannot read 79 papers. Whatever comes back, read it and ask yourself
two questions:

1. Could I check any sentence of this against the papers?
2. Imagine a colleague handed you this result. Before you would cite it or
   act on it, **write one specific thing the result would have to show you
   that you could go and check yourself.**

Write what the result would have to *contain*, not what you would ask the
colleague. Write it on line 1 of your exit card (the one with four numbered
lines). It becomes criterion 5 in the next pass, and you will watch the agent
meet it.

## If this went wrong

- Nothing happened for two minutes: raise a hand.
- `bash: What: command not found` (or similar): you pasted into the plain
  terminal, not the agent. Type `openclaw chat`, press Enter, then paste again.
  If it says `openclaw: command not found`, run `bash setup.sh` first.
- It asked you a question: answer "just do your best" and press Enter.
