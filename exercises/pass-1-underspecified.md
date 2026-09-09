# Pass 1: ask badly

**Where you are:** the agent prompt is open in your terminal. If it is not,
type `openclaw chat` and press Enter.

Copy this line, paste it at the agent prompt, press Enter, and do not help
it:

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

Question 2 is the one that matters, and note what it is not asking. It is not
asking what you would *say* to that colleague — "how did you do this?" is a
conversation, not a criterion. It is asking what the result would have to
*contain* for you to be able to verify it without taking anyone's word for it.

Write that on your card. It becomes criterion 5 in the next pass, in your own
words, and you will watch the agent meet it.

If the answer looks good anyway, ask a third question: which requirements
did it decide on its own, and would you trust it to decide them the same
way on a task you cared about?

## If this went wrong

- Nothing happened for two minutes: raise a hand.
- `command not found`: type `openclaw chat` and press Enter, then paste again.
- It asked you a question: answer "just do your best" and press Enter.
