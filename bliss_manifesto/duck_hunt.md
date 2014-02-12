title: II. Duck Hunt
author: radi
date: 2014-02-07
tags: ruby, rspec, interface polymorphism, oop

![Duck Hunt](http://i.imgur.com/ZZc5xEm.png)

[Duck typing](http://en.wikipedia.org/wiki/Duck_typing) is a really powerful
concept, but let's be honest: It's a pain in the pooper to identify implicit
interfaces in code you haven't written yourself or just haven't looked at for a
while. In Bliss, we simplify the duck hunt by following __naming conventions__, writing
smart __documentation__ and using the __shared examples__ feature of Rspec.

When a method expects a duck rather than an instance of some concrete
class, __name the argument the same as you'd name the duck type__. Say there's
a method `#convert_line_item_prices` that takes an `order` as an argument,
but the method only expects the `order` to respond to `#line_items`, we
tend to name the argument __`receipt`__. So instead of this:

```ruby
def convert_line_item_prices(order)
  line_items = order.line_items
  # converting of line_items ensues...
end
```
we write this:

```ruby
def convert_line_item_prices(receipt)
  line_items = receipt.line_items
  # converting of line_items ensues...
end
```

You will find no class named `Receipt` in Bliss, because `Receipt` is an
implicit [Interface](http://en.wikipedia.org/wiki/Protocol_(object-oriented_programming))
we refer to when we talk about things that respond to the
method `#line_items` (and some other methods we're leaving out for
simplicity's sake). In Bliss, there are several classes that "act like a
`Receipt`", like `Invoice`, `CostBreakdown`, or `QuantitySplit`. Naming the
argument `receipt` indicates that `#convert_line_item_prices` can and should be (re)used with
__all__ of these objects and not only with instances of __one__ concrete
class, like `Order`. This is a fair enough technique to reveal the duck type
`Receipt` but knowledge of the public interface of `Receipt` is still implied
and therefore hidden for developers not familiar with it.

Naming conventions alone cannot expose the public interface of a duck type. They
merely hint to an existance of it. We advice to always __declare what methods the
duck type is expected to respond to__. Write these expectations down in the documentation
of the method that takes duck types as arguments:

```ruby
# Expects `receipt` to implement #line_items that returns a collection of
# `LineItem`s. A `LineItem` must implement #price_value and
# #price_currency.
def convert_line_item_prices(receipt)
  line_items = receipt.line_items
  # converting of line_items ensues...
end
```

Some ruby documentation tools like [YARD](http://rubydoc.info/gems/yard/file/docs/Tags.md#Duck-Types)
even have built-in tags that support this kind of duck type documentation:

```ruby
# @param [#line_items] a receipt that holds a collection of `line_items`
def convert_line_item_prices(receipt)
  line_items = receipt.line_items
  # converting of line_items ensues...
end

# As a side note, we don't use YARD in Bliss,
# but we started using it for new projects.
```

This way, other developers know exatly what is required by
`#convert_line_item_prices` even when they have never heard of `Receipt` before.


Naming convetions and documentation aside, nothing exposes a duck type more than
an actual class or module that defines it, so many suggest doing something
like this:

```ruby
# Interface for a Receipt
module Receipt
  def line_items
    raise NotImplementedError
  end

  def total_price
    raise NotImplementedError
  end

  # other receipt methods...
end

# Receipt then gets mixed into classes that behave like a receipt.
class Order
  include Receipt

  def line_items
    # order implementation of line items
  end

  # ...
end

class Invoice
  include Receipt

  def line_items
    # invoice implementation of line items
  end
end

class CostBreakdown
  include Receipt

  def line_items
    # cost breakdown implementation of line items
  end
end

class QuantitySplit
  include Receipt

  def line_items
    # quantity split implementation of line items
  end
end
```

In Bliss, we try to avoid this. We only extract duck types to a module if
the implementation can be shared. It's not very Ruby-like anyway. As an alternative, we
propose to write __[shared examples](https://www.relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples)
that describe the public interface__ and then include these examples to all
object specs that behave like the described duck type:

```ruby
# spec/models/receipt_spec.rb

shared_examples_for "a receipt" do
  let(:receipt) { described_class.new }

  describe "#line_items" do
    it "should exist" do
      receipt.should respond_to :line_items
    end

    it "should return a collection of ..." do
    end

    it "should yada yada yada..." do
    end
  end


  it { receipt.should respond_to :total_price }
end

# spec/models/order_spec.rb
describe Order do
  it_behaves_like "a receipt"
end

# spec/models/invoice_spec.rb
describe Invoice do
  it_behaves_like "a receipt"
end

# spec/models/cost_breakdown_spec.rb
# ...
```

This way of exposing duck types doesn't restrict how we actually implement them,
but still provides a central place to collect specifications of the most common
duck types in our business models.

These are some basic techniques we use in Bliss to shorten the length of
your tedious duck hunt, fellow developer. So if you stumble across our code, pay
attention to how we named method arguments. If you can't find conrete classes
that correspondent to the argument name, it's probably a duck type we're
referring to. You don't know what methods that duck type responds to? Check the method's
documentation or search the specs for shared examples that describe that duck
type.

Well, at least that's how it would work in a perfect world. In most cases you
will disappointingly realise that we did none of the aforementioned things to
simplify your hunt. That's because we are bloody hypocrites. There must be some
reason you brought your shotgun to the hunt, right?





