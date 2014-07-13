title: VI. Searches
author: radi
date: 2014-07-13
tags: search, bliss

We recently had to extend the search functionality of Bliss using the existing
library that was initially written by the late Michael Waelti. This entry serves
as a little guide to implementing a custom search in Bliss 0.6.5.

Our goal is to implement a producer search, so that a user can enter the name of
a producer in the search bar and get a list of producers with names that match
the entered keywords, but before we start, let's take a little peek behind the
curtains.

Michi build, what he called, a search aggregate. The aggregate makes it more or
less easy to add custom searches by simply defining a class and making it comply
to an interface that the aggregate and the view can talk to.

A search class takes care of fetching the results for given keywords. Before
actually implementing it, we add the class to the list of general search classes
in `general_search.rb`, where the aggregate is defined. Since we're searching for
producers, we'll name our class `ProducerSearch`:

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

The order of the `SEARCH_CLASSES Array` matters. The way search results
rendering works right now, the results fetched by the classes listed first get
displayed first as well. So the results of the `ProgramSearch` appear first on the
page.

Ok, let's get down to business. We'll create a file in `app/models/searches/`
named `producer_search.rb`:

```ruby
# app/models/searches/producer_search.rb

class ProducerSearch
  include BasicSearch
end
```

The `BasicSearch` Module provides some of the methods the aggregate and the view
depend on. We'll ignore the nitty-gritties for now and accept the fact that we
have to include it.

There are two methods we absolutely have to implement to make `ProducerSearch`
spit out some results: `#key` and `#search`. `#key` has to return a unique
`Symbol`. The aggregate internally uses this Symbol for the results hash and the
template lookup. `#search` has to return the results in an `Array` or
`ActiveRecord::Relation`:

```ruby
# app/models/searches/producer_search.rb

class ProducerSearch
  include BasicSearch

  def key
    :producers
  end

  def search
    Production::Producer.where("name like ?", "%#{keywords}%")
  end
end
```

`#keywords` is one of the methods `BasicSearch` provides. It returns whatever
the user entered in the search field as a `String`.

To display the results in the view we have to add a partial named `_producers_results.haml`
(as a result of returning `:producers` in `#key`) in `app/views/shared/searches/`. In
that partial we have access to an Array called `results` which is basically
whatever we returned in `#search`. The partial for a very simple list of links
that redirect to the producer's show page could look like this:

```haml
/ app/views/shared/searches/_producers_results.haml

%h2 Producers
%hr.dark
%ul
  - results.each do |producer|
    %li{:class => list_colour}
      = link_to producer.name, producer, :class => "text"
```

How it looks like for the keywords "chan":

![Producer Search](http://i.imgur.com/jlTPWkI.png)

This all works fine and dandy, but we totally ignored authorization. The
way it is implemented now, even producers can search for other producers. To
disable search classes completely we can utilize another method, namely
`.enabled?(authorizer)`:

```ruby
# app/models/searches/producer_search.rb

class ProducerSearch
  include BasicSearch

  def self.enabled?(authorizer)
    authorizer.permitted_to? :display, :production_producers
  end

  def key
    :producers
  end

  def search
    Production::Producer.where("name like ?", "%#{keywords}%")
  end
end
```

The `authorizer` is essentially the view context at the moment of fetching
results, so we have access to all methods provided by
[declarative_authorization](https://github.com/stffn/declarative_authorization).
With the addition of the `.enabled?` implementation, the search aggregate will
now ignore the `ProducerSearch` if the `current_user` is not allowed to diplay
producers.

How the results for "chan" look like for a producer:

![Producer Search for a Producer](http://i.imgur.com/ohXowLT.png)

And that's all you have to do. Add the class to the list of search classes in
`general_searches.rb` and implement `#key`, `#search` and if authorization is
necessary, `.enabled?(authorizer)`. Then, create a partial `_<key>_results.haml`
that describes how the `#results` need to be rendered.
