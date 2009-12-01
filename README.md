# README

Chronos provides flexible date parsing. Currently, it is just a thin wrapper over [ParseDate](http://ruby-doc.org/stdlib/libdoc/parsedate/rdoc/index.html). Here is how it works:

    c = Chronos.parse("1991")
    c.year
    # => 1991
    # these work too: "91" and "'91"

    Chronos.parse("1/17/2007")
    c.year
    # => 2007

    Chronos.parse("January 1976")
    c.year
    # => 1976

At present, neither [Chronic](http://github.com/mojombo/chronic) nor ParseDate parses a plain year (e.g. "1991") correctly.

In the future, I would like Chronos to be able to handle comparisons properly. Most Ruby date libraries seem to have the assumption that you are specifying a point, not an interval. Comparing intervals adds a little bit of complexity. For example:

    c1 = Chronos.parse("1974")
    c2 = Chronos.parse("March 1974")
    c1 < c2 # => false
    c1 > c2 # => false
    c1 == c2 # => false
    c1.in?(c2) # => false
    c2.in?(c1) # => true

I have not yet seen Ruby date libraries that behave in this way.
