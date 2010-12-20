# Kronos

Kronos is a library for Ruby that provides flexible date-related parsing. 

## Introduction

The approach of Kronos is simple: parse what you can and don't be more specific than is justified. In other words, don't attempt to force the rest into a Date object. It can handle a date, just a month and day, or just a year. Some examples:

    c = Kronos.parse("1991")
    c.year  # => 1991
    c.month # => nil
    c.day   # => nil

    # These give the same results:
    c = Kronos.parse("91")
    c = Kronos.parse("'91")

    Kronos.parse("1/17/2007")
    c.year  # => 2007
    c.month # => 1
    c.day   # => 17

    Kronos.parse("January 1976")
    c.year  # => 1976
    c.month # => 1
    c.day   # => nil

## Comparison with other libraries

In contrast, other date parsing libraries, such as [Chronic](http://github.com/mojombo/chronic), [ParseDate](http://ruby-doc.org/stdlib/libdoc/parsedate/rdoc/index.html), or [Timeliness](https://github.com/adzap/timeliness) try to parse a string into a full Date object, which requires a year, month, and day. Even if a month or day is not specified, they are going to pick one for you. For example:

    require 'parsedate'
    require 'chronic'
    require 'timeliness'

    # "Aug-96"

    Chronic.parse("Aug-96")
    # => Fri Aug 16 12:00:00 -0400 1996
    # The day (16) is arbitrarily chosen

    ParseDate.parsedate("Aug-96")
    # => [nil, 8, 96, nil, nil, nil, nil, nil]
    # The year (nil) is wrong
    # The day (96) is arbitrarily chosen and out of range

    Timeliness.add_formats(:date, "mmm-yy")
    t = Timeliness.parse("Aug-96")
    [t.year, t.month, t.day]
    # => [1996, 8, 19] 
    # The day (19) is arbitrarily chosen

    # "1991"

    Chronic.parse("1991")
    # => Fri Dec 11 20:31:00 -0500 2009
    # The year is wrong (2009)
    # The month (12) and day (11) are arbitrarily chosen

    ParseDate.parsedate("1991")
    # => [nil, 19, 91, nil, nil, nil, nil, nil]
    # The year is wrong (nil)
    # The month (19) and day (91) are arbitrarily chosen and out of range

    Timeliness.add_formats(:date, "yyyy")
    Timeliness.parse("1991")
    [t.year, t.month, t.day]
    # => [1991, 12, 19] 
    # The month (12) and day (19) is arbitrarily chosen

## Implementation

The current version of Kronos relies upon a long sequence of `Date.strptime` calls to parse various possible date strings. Why? Because `strptime`, unlike many date-parsing libraries, is (1) pretty good about failing when it cannot parse a string correctly and (2) unlikely to give false positives. However, there are still edge cases, so Kronos runs the potential match in reverse (using `strftime`) to see if it matches the original -- only then is the parse accepted as valid.

As a historical note, Kronos 0.2.x and earlier was implemented as a thin wrapper over [ParseDate](http://ruby-doc.org/stdlib/libdoc/parsedate/rdoc/index.html). This strategy had to change for Ruby 1.9 because ParseDate support was removed from the standard library.

## Date Comparisons

Kronos handles date-related comparisons more intelligently.

Many Ruby date libraries make the assumption that you are specifying a point (i.e. a particular date), not an interval (such as an entire month or year). Kronos, on the other hand, lets you specify dates that are intervals:

    k_1973       = Kronos.parse("1973")
    k_1974       = Kronos.parse("1974")
    k_march_1974 = Kronos.parse("March 1974")

With Kronos, you can compare date objects as follows:

    k_1973 < k_1974          # => true
    k_1973 < k_march_1974    # => true

### A Note about Kronos Comparison Operators

Kronos interprets `<` as "Does the date interval on the left occur completely before the date interval on the right?" In other words, if there is overlap, the result will be false.

Here's an example. If you ask "Does the year 1974 come before March 1974?" a careful response might be: "Actually, part of it comes before and part of it comes after. Your question does not really make sense because March 1974 is contained within the year 1974."

Because of this, Konos comparison operators (`<`, `==`, `>`) behave a little bit differently for Kronos objects than for, say, integers. Given any two integers m and n, you can be sure that one of the operators holds. For example:

    m = 1
    n = 2
    m < n   # => true
    m == n  # => false
    m > n   # => false

However, given two Kronos objects k1 and k2 you cannot guarantee that one of the operators will hold. For example:

    k_1974 < k_march_1974    # => false
    k_1973 == k_march_1974   # => false
    k_1974 > k_march_1974    # => false

Since the two dates are unequal but overlap, Kronos will always return false.

### Future Work

I plan to implement the `in?` method as follows:

    k_march_1974.in?(k_1974) # => true
    k_1974.in?(k_march_1974) # => false

## History

We import a lot of data from government Web sites as part of our work at the Sunlight Labs (the technical arm of the Sunlight Foundation). I did not want to store date-related information in a way that made it seem more precise than it really was, so I wrote this little library. -David

## Contributors

* David James (djsun)
* Eric Mill (klondike)

## Feedback

We would appreciate your feedback. Thanks!
