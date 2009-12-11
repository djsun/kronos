require 'parsedate'

class Kronos
  
  attr_accessor :year, :month, :day
  
  def parse(string)
    if string =~ /^\d{4}$/
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
  
  def to_hash
    h = {}
    h['year']  = year  if year
    h['month'] = month if month
    h['day']   = day   if day
    h
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