# 2010

Date.parse('2010')
ArgumentError: invalid date

Date.strptime('2010', '%m/%d/%Y')
ArgumentError: invalid date

Chronic.parse('2010')
TypeError: can't convert Chronic::RepeaterTime::Tick into an exact number

Timeliness.parse('2010')
nil

# January

Date.parse('January')
=> #<Date: 2010-01-01 (4910395/2,0,2299161)> 

Date.strptime('January', '%m/%d/%Y')
ArgumentError: invalid date

Chronic.parse('January')
=> 2011-01-16 12:00:00 -0500

Timeliness.parse('January')
nil

# February 2010

Date.parse('February 2010')
=> #<Date: 2010-02-01 (4910457/2,0,2299161)>

Date.strptime('February 2010', '%m/%d/%Y')
ArgumentError: invalid date

Chronic.parse('February 2010')
=> 2010-02-15 00:00:00 -0500

Timeliness.parse('February 2010')
nil

# February 9, 2010

Date.parse('February 9, 2010')
=> #<Date: 2010-02-09 (4910473/2,0,2299161)>

Date.strptime('February 9, 2010', '%m/%d/%Y')
ArgumentError: invalid date

Chronic.parse('February 9, 2010')
nil

Timeliness.parse('February 9, 2010')
nil
