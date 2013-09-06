title: When to use Rails Engines
author: radi
date: 2013-09-05

![The disease](http://clipartist.info/clipart/pligg/COLOURINGBOOK.ORG/ryanlerch_steam_train_engine-1331px.png "The disease")

At [Fadendaten][0], we recently started to fancy some heavy use of
[Rails Engines][1], so we decided to write up some guidelines about when, or
especially when __not__ to use them.

Consider using a Rails Engine when:

1. __You have to share at least two of the following components: Models,
Controllers or Views.__ ...

2. __The Engine can be extracted from existing code.__ Good Engines,
like good web frameworks, do not come out of nowhere. ...

3. __The Engine will be used in at least two of your existing Applications.__
It is not worth extracting an Engine if you will not be using it anywhere
else. That's it. Keep it simple. Extracting an engine because the tests run
faster in a separate engine environment or it just making more sense to you
to manage the non domain specific code in a engine upfront is not about keeping
your system simple. It is about making it convenient for you.
[Not the same thing.][2]


[0]: http://www.fadendaten.ch
[1]: http://edgeguides.rubyonrails.org/engines.html
[2]: http://www.youtube.com/watch?v=rI8tNMsozo0
