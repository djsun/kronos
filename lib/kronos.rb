require 'parsedate'

class Kronos
  
  attr_accessor :year, :month, :day
  
  IGNORE_PATTERN = Regexp.compile("^prior")
  
  def parse(string)
    if string.nil? || string =~ IGNORE_PATTERN
      nil # do nothing
    elsif string =~ /^\d{4}$/
      self.year = string.to_i
    elsif string =~ /^[']?(\d{2})$/
      self.year = to_full_year($1.to_i)
    else
      values = ParseDate.parsedate(string)
      if values[0]
        # ParseDate parsed a year
        self.year  = to_full_year(values[0])
        self.month = values[1]
        self.day   = values[2]
      elsif values[2]
        # ParseDate parsed a day but not a year
        self.year  = to_full_year(values[2])
        self.month = values[1]
        self.day   = nil
      end
    end
    self
  end
  
  def to_s
    s = ""
    raise "Invalid" unless valid?
    s << "%04i" % year if year
    s << "/%02i" % month if month
    s << "/%02i" % day if day
    s
  end
  
  def valid?
    if day && (!month || !year)
      false
    elsif month && !year
      false
    elsif !year
      false
    else
      true
    end
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
          raise "Unexpected"
        end
      end
    else
      raise "Unexpected"
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
          raise "Unexpected"
        end
      end
    else
      raise "Unexpected"
    end
  end
  
  def to_hash
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
    o if o.valid?
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