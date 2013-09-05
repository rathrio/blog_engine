title: When to use Rails Engines
author: radi
date: 2013-09-04

![The disease](http://www.clker.com/cliparts/2/d/7/9/11971183911319983970ryanlerch_Steam_Train_Engine.svg.hi.png "The disease")

Some of us at [Fadendaten][0] recently started to fancy some heavy use of
[Rails Engines][1], so we decided to write up some guidelines about when, or
especially when __not__ to use Rails Engines.

Consider using a Rails Engine when:

1. You have to share at least two of the following components: Models,
   Controllers or Views.

2. The Engine can be extracted from existing code.

Good Engines, like good web frameworks, do not

3. The Engine will be used in at least two of your existing Applications.


[0]: http://www.fadendaten.ch
[1]: http://edgeguides.rubyonrails.org/engines.html


