title: Recipe suggestion app
author: radi
date: 2014-01-28
tags: webapp, cooking

__Basic idea__

1. User enters ingredients that she has to her disposal at home
2. Submits data through webapp/mobile app/mobile front end
3. App crawls da web for recipes that could be cooked with given ingredients

Actually crawling should happen in advance. A precomputed dataset of recipes
should already exist when the user enters ingredients.

__Implementation__

Single's hints: Use dynamic programming techniques to find best match fast.

__Scenario 1__ User enter two ingredients: _rice_ and _eggs_

Best matches are recipes that only require rice and eggs. The next best are
those that require one ingredient more, and so forth. One could ignore the most
common spices, like salt and pepper ore introduce some king of weight for
ingredients.




__Existing solutions__

* [supercook](http://www.supercook.com/)
* [restegourmet](http://restegourmet.de/)
