title: V. Searches
author: radi
date: 2014-07-04
tags: search

This is WIP.

We recently had to extend the search functionality of Bliss using the existing
library that was initially written by the late Michael Waelti. This entry serves
as a little guide to implementing a custom search in Bliss 0.6.5.

Our goal is to implement a producer search, so that a user can enter the name of
a producer in the search bar and get a list of producers with names that match
the entered keywords.

Michi build, what he called, a search aggregate. The aggregate makes it more or
less easy to add custom searches by simply defining a class and making it comply
to an interface that the aggregate and the view can talk to.

A search class takes care of fetching the results for given keywords. Before
actually implementing it, we add the class to the list of general search classes
in `general_search.rb`, where the aggregate is defined. Since we're searching for
producers, we'll name our class `ProducerSearch` (a convention Michi introduced):

```ruby
# app/models/searches/general_search.rb

# Just add general search classes here and make sure they comply to the
# search interface.
SEARCH_CLASSES = [
  ProgramSearch,
  StyleSearch,
  ArticleSearch,
  CustomerSearch,
  EmployeeSearch,
  AwwSearch,
  ProducerSearch
]
```
