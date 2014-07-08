title: Use Devise
author: jugglinghobo
date: 2014-02-15
tags: third party libraries, team communication

article structure

* anecdote: 'use devise', how it all started
* what sucked about this
* how it helped us understand
* asking advice
* giving advice
* question of form? "use devise" instead of "i just know that devise does this and this."

a

#### Backstory
When [Radi](https://github.com/rathrio) and I first started working at [Fadendaten](http://www.fadendaten.ch),
our first assignment was to build a simple Customer Relationship Management app.
Since neither of us had any practical experience with ruby/rails up to this point,
the project included a lot of 'learning by doing'. We were also offered help by our teammate [Felix](https://www.github.com/flangenegger)
and our boss, [Chrigu](https://www.github.com/derwiedmer),
and had the possibility to inspect and adopt similar features from Bliss,
the already working system, which we often did.

One of the obstacles to overcome was Account management, specifically __Authentication and Authorisation__.
Both radi and I had completed Michael Hartl's excellent [tutorial](http://ruby.railstutorial.org/),
and we swiftly implemented the User model and authentication service as suggested in chapters 6, 7, and 8.
As soon as everything worked, it was time to face the authorisation part.

#### Where the fun begins
Since we were dealing with different user roles, we couldn't simply copy
[Hartl's solution](http://ruby.railstutorial.org/chapters/user-microposts#sec-access_control),
and had to come up with something else.
We asked our mates for advice, and the answer was a conclusive
'You should use [devise](https://github.com/plataformatec/devise) for this'.

Now, if you're a new developer, and you ask your clearly more informed colleagues
for a solution to a problem, and they tell you to use an external library, or a gem,
do you read its documentation? Do you google for similar use cases?

![nope shaking head](http://i.imgur.com/qCSKNpZ.gif)

__Nope!__

Instead, we instantly started integrating devise into our project, and were glad because
we could move on to other tasks and let this external 'super solution' do the job for us.

![devise is good commits](http://i.imgur.com/S5k66r8.png)

When we finally realised that devise has nothing to do with authorisation,
we had already replaced about one third of our codebase with it.
What followed can best be described as a collective facepalm.

![devise is bad commits](http://i.imgur.com/CHq6yoH.png)


We had spent two days replacing our lightweight, easy-to-understand authentication
with this bloated and complicated gem. I'm not sure if we even kept using devise after
figuring out what it is intended for, but that's beside the point. What is really interesting
is __how could this happen?__

#### Why would you even do that?!
The most obvious argument for why we did this is clearly: *our mentors told us to*.




