require File.expand_path('../version', __FILE__)
require 'date'

class Kronos

  class Exception < RuntimeError; end
  class Invalid < Exception; end

  attr_accessor :year, :month, :day

  IGNORE_PATTERN = Regexp.compile('^prior')

  def parse(string)
    if string.nil? || string =~ IGNORE_PATTERN
      nil # do nothing
    elsif\
      p = parse_date(string, '%Y-%m-%d') || # 1988-09-23
      p = parse_date(string, '%Y-%b-%d') || # 1988-Sep-23
      p = parse_date(string, '%Y-%B-%d') || # 1988-September-23
      p = parse_date(string, '%y-%m-%d') || # 88-9-23
      p = parse_date(string, '%y-%b-%d') || # 88-Sep-23
      p = parse_date(string, '%y-%B-%d') || # 88-September-23
      p = parse_date(string, '%m/%d/%Y') || # 9/23/1988
      p = parse_date(string, '%b/%d/%Y') || # Sep/23/1988
      p = parse_date(string, '%B/%d/%Y') || # September/23/1988
      p = parse_date(string, '%m/%d/%y') || # 11/23/88
      p = parse_date(string, '%b/%d/%y') || # Sep/23/88
      p = parse_date(string, '%B/%d/%y') || # September/23/88
      p = parse_date(string, '%m-%d-%Y') || # 11-23-1988
      p = parse_date(string, '%b-%d-%Y') || # Sep-23-1988
      p = parse_date(string, '%B-%d-%Y') || # September-23-1988
      p = parse_date(string, '%m %d %Y') || # 11 23 1988
      p = parse_date(string, '%b %d %Y') || # Sep 23 1988
      p = parse_date(string, '%B %d %Y') || # September 23 1988
      p = parse_date(string, '%m %d %y') || # 11 23 88
      p = parse_date(string, '%b %d %y') || # Sep 23 88
      p = parse_date(string, '%B %d %y') || # September 23 88
      p = parse_date(string, '%d-%b-%Y') || # 23-Sep-1988
      p = parse_date(string, '%d-%B-%Y') || # 23-September-1988
      p = parse_date(string, '%d-%b-%y') || # 23-Sep-88
      p = parse_date(string, '%d-%B-%y') || # 23-September-88
      p = parse_date(string, '%d %b %Y') || # 23 Sep 1988
      p = parse_date(string, '%d %B %Y') || # 23 September 1988
      p = parse_date(string, '%d %b %y') || # 23 Sep 88
      p = parse_date(string, '%d %B %y') || # 23 September 88
      false
      self.year  = to_full_year(p.year)
      self.month = p.month
      self.day   = p.day
    elsif\
      p = parse_date(string, '%Y-%m') || # 1976-4
      p = parse_date(string, '%Y-%b') || # 1976-Apr
      p = parse_date(string, '%Y-%B') || # 1976-April
      p = parse_date(string, '%m/%Y') || # 4/1976
      p = parse_date(string, '%b/%Y') || # Apr/1976
      p = parse_date(string, '%B/%Y') || # April/1976
      p = parse_date(string, '%m-%Y') || # 4-1976
      p = parse_date(string, '%b-%Y') || # Apr-1976
      p = parse_date(string, '%B-%Y') || # April-1976
      p = parse_date(string, '%m %Y') || # 4 1976
      p = parse_date(string, '%b %Y') || # Apr 1976
      p = parse_date(string, '%B %Y') || # April 1976
      p = parse_date(string, '%m/%y') || # 4/76
      p = parse_date(string, '%b/%y') || # Apr/76
      p = parse_date(string, '%B/%y') || # April/76
      p = parse_date(string, '%m-%y') || # 4-76
      p = parse_date(string, '%b-%y') || # Apr-76
      p = parse_date(string, '%B-%y') || # April-76
      p = parse_date(string, '%m %y') || # 4 76
      p = parse_date(string, '%b %y') || # Apr 76
      p = parse_date(string, '%B %y') || # April 76
      false
      self.year  = to_full_year(p.year)
      self.month = p.month
    elsif\
      p = parse_date(string, '%Y') || # 1991
      p = parse_date(string, '%y') || # 91
      false
      self.year = to_full_year(p.year)
    elsif\
      string =~ /^[']?(\d{2})$/ # '91
      self.year = to_full_year($1.to_i)
    end
    self
  end

  # This method:
  #   1. Swallows ArgumentError from Date.strptime
  #   2. Does not trust a match from Date.strptime unless it matches the
  #      inverse operation, namely Date#strftime.
  #   3. However, the inverse operation is complicated by the way that
  #      #strftime handles leading zeros. For now, I have a hack that
  #      removes leading zeros.
  def parse_date(original, format)
    parsed = Date.strptime(original, format)
    t1 = parsed.strftime(format)
    t2 = t1.gsub('/0', '/').gsub('-0', '-').gsub(/^0/, '')
    return unless original == t1 || original == t2
    parsed
  rescue ArgumentError
    nil
  end

  def to_s
    s = ''
    raise Invalid, errors unless valid?
    s << '%04i' % year if year
    s << '-%02i' % month if month
    s << '-%02i' % day if day
    s
  end

  def errors
    errors = []
    if day && (!month || !year)
      errors << 'if day is given, then month and year must also be given'
    elsif month && !year
      errors << 'if month is given, then year must also be given'
    elsif !year
      errors << 'year must be given'
    else
      if day && !((1 .. 31) === day)
        errors << "day (#{day}) must be between 1 and 31"
      end
      if month && !((1 .. 12) === month)
        errors << "month (#{month}) must be between 1 and 12"
      end
      if year && !((1970 .. 2069) === year)
        errors << "year (#{year}) must be between 1970 and 2069"
      end
      if errors.length == 0 && day && month && year
        begin
          Date.new(year, month, day)
        rescue ArgumentError
          errors << "date (#{year}-#{month}-#{day}) must be valid"
        end
      end
    end
    errors
  end

  def valid?
    errors.length == 0
  end

  def <(other)
    if !self.year || !other.year
      false
    elsif self.year < other.year
      true
    elsif self.year > other.year
      false
    elsif self.year == other.year
      if !self.month || !other.month
        false
      elsif self.month < other.month
        true
      elsif self.month > other.month
        false
      elsif self.month == other.month
        if !self.day || !other.day
          false
        elsif self.day < other.day
          true
        elsif self.day > other.day
          false
        elsif self.day == other.day
          false
        else
          raise Exception, 'unexpected error'
        end
      end
    else
      raise Exception, 'unexpected error'
    end
  end

  def <=(other)
    (self < other) || (self == other)
  end

  def ==(other)
    self.year == other.year &&
    self.month == other.month &&
    self.day == other.day 
  end

  def >=(other)
    (self > other) || (self == other)
  end

  def >(other)
    if !self.year || !other.year
      false
    elsif self.year < other.year
      false
    elsif self.year > other.year
      true
    elsif self.year == other.year
      if !self.month || !other.month
        false
      elsif self.month < other.month
        false
      elsif self.month > other.month
        true
      elsif self.month == other.month
        if !self.day || !other.day
          false
        elsif self.day < other.day
          false
        elsif self.day > other.day
          true
        elsif self.day == other.day
          false
        else
          raise Exception, 'unexpected error'
        end
      end
    else
      raise Exception, 'unexpected error'
    end
  end

  def to_hash
    raise Invalid, errors unless valid?
    h = {}
    h['year']  = year  if year
    h['month'] = month if month
    h['day']   = day   if day
    h
  end

  def self.from_hash(h)
    o = self.new
    o.year  = h['year']  if h['year']
    o.month = h['month'] if h['month']
    o.day   = h['day']   if h['day']
    o
  end

  def self.parse(string)
    self.new.parse(string)
  end

  protected

  def to_full_year(x)
    case x
    when (0 .. 69)  then 2000 + x
    when (70 .. 99) then 1900 + x
    else x
    end
  end

end
