require 'parsedate'

class Chronos
  
  attr_accessor :year, :month, :day
  
  def parse(string)
    if string =~ /^\d{4}$/
      self.year = string.to_i
    elsif string =~ /^[']?(\d{2})$/
      n = $1.to_i
      self.year = n >= 70 ? 1900 + n : 2000 + n
    else
      values = ParseDate.parsedate(string)
      self.year  = values[0]
      self.month = values[1]
      self.day   = values[2]
    end
    self
  end
  
  def self.parse(string)
    self.new.parse(string)
  end
  
end