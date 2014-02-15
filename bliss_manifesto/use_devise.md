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
Since none of us had any practical experience with ruby/rails up to this point,
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

![nope](http://i.imgur.com/qCSKNpZ.gif)

What we did instead is this:

* add devise to our Gemfile
* remove our own user resource because it was not compliant with devise's expectations and we were too inexperienced to make the necessary changes by hand
* fight with a very complicated pre-made solution which was too bloated for what we needed

Some excerpts:

![devise commits](http://i.imgur.com/S5k66r8.png)









