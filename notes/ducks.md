title: Mighty Ducks
author: radi
date: 2014-02-09
tags: oop, ruby

In the dynamically typed universe of Ruby, code that depends on some objects doesn't
give a flying fuck about the class or ancestry of them. The only thing that truly
matters is what messages the objects respond to.

I'd like to think of it as code in a
statically typed languages being a judgemental dickhead.

The code needs to get things
done and it depends on one or more objects that do some of the dirty work,
but it will only agree to collaborate with them if it knows what class their
from rather than trusting their claim that their qualified to do the job. Let's
have a look at a scenario that further illustrates this analogy:


* Methods can be named the same but belong to different roles


Possible analogy: Your the boss, you have hire recruiter that does interviews
before
