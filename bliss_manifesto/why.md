title: IV. Why
author: radi
date: 2014-02-23

"Why?" is a question that comes up a lot in the average developers life. "Why was
this change necessary?", "Why does this method even exist?", "Why does that
variable have such a stupid name?" or "Why don't I look for another job already?"
may be fairly common utterances in the troubled mind of your dear coworker.

To make life easier, we propose that you always keep these questions in mind
while writing commit messages, documentation, guides and so on, especially you're good
judgment tells you that things may not be inherently clear to anybody else than
yourself.

Say you're composing a commit message for a bug fix, instead of:

```
fixed bug on customer show page
```

how about:

```
Added guard to #that_method to make customer show page render again

https://trello.com/c/link/to/bug/card

We recently allowed #this_method to return nil and didn't guard #that_method
and that led to the NoMethodError on the show page.
```

Not only does this message provide a link to the initial bug report, but also
adds a short summary describing why this fix was necessary. For your coworker,
this might immensely shorten the time spend trying to comprehend your changes,
for example, when he/she has to do a code review. And it also reduces the amount
  of interruptions and stupid questions you get while trying to get shit done.

WIP
