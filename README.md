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

In contrast, other date parsing libraries, such as [Chronic](http://github.com/mojombo/chronic) or [ParseDate](http://ruby-doc.org/stdlib/libdoc/parsedate/rdoc/index.html), try to parse a string into a full Date object, which requires a year, month, and day. Even if a month or day is not specified, they are going to pick one for you. For example:

    require 'parsedate'
    require 'chronic'

    Chronic.parse("Aug-96")
    # => Fri Aug 16 12:00:00 -0400 1996
    # The day (16) is arbitrarily chosen
    
    ParseDate.parsedate("Aug-96")
    # => [nil, 8, 96, nil, nil, nil, nil, nil]
    # The year (nil) is wrong
    # The day (96) is arbitrarily chosen and out of range
    
    Chronic.parse("1991")
    # => Fri Dec 11 20:31:00 -0500 2009
    # The year is wrong (2009)
    # The month (12) and day (11) are arbitrarily chosen
    
    ParseDate.parsedate("1991")
    # => [nil, 19, 91, nil, nil, nil, nil, nil]
    # The year is wrong (nil)
    # The month (19) and day (91) are arbitrarily chosen and out of range

## Implementation

Kronos is currently implemented as a thin wrapper over [ParseDate](http://ruby-doc.org/stdlib/libdoc/parsedate/rdoc/index.html).

## Future Plans

In the future, I would like Kronos to be able to handle date-related comparisons properly.

The Ruby date libraries that I have seen make the assumption that you are specifying a point (i.e. a particular date), not an interval (such as an entire month or year). Comparing intervals adds a little bit of complexity. For example:

    k_1974       = Kronos.parse("1974")
    k_march_1974 = Kronos.parse("March 1974")
    k_1974 < k_march_1974    # => false
	k_1974 > k_march_1974    # => false
	k_1974 == k_march_1974   # => false
	k_march_1974.in?(k_1974) # => true
	k_1974.in?(k_march_1974) # => false

## History

We import a lot of data from government Web sites as part of our work at the Sunlight Labs (the technical arm of the Sunlight Foundation). I did not want to store date-related information in a way that made it seem more precise than it really was, so I wrote this little library. -David

## Contributors

David James (djsun)
Eric Mill (klondike)

## Feedback

I would appreciate your feedback. Thanks! (David James, Sunlight Labs, Washington, DC)
