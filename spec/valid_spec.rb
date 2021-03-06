require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kronos Comparisons" do

  def new_kronos(year=nil, month=nil, day=nil)
    k = Kronos.new
    k.year  = year if year
    k.month = month if month
    k.day   = day if day
    k
  end

  it "year only is valid" do
    new_kronos(2005).valid?.should be_true
  end

  it "month and year is valid" do
    new_kronos(2005, 8).valid?.should be_true
  end

  it "day and year is invalid" do
    new_kronos(2005, nil, 22).valid?.should be_false
  end

  it "nothing is invalid" do
    new_kronos(nil, nil, nil).valid?.should be_false
  end

  it "month, day, and year is valid" do
    new_kronos(2005, 8, 22).valid?.should be_true
  end

  it "month, day, and year with out-of-range month is invalid" do
    new_kronos(2005, 13, 22).valid?.should be_false
  end

  it "month, day, and year with out-of-range day is invalid" do
    new_kronos(2005, 4, 32).valid?.should be_false
  end

  it "June 0, 2005 is invalid" do
    new_kronos(2005, 6, 0).valid?.should be_false
  end

  it "June 31, 2005 is invalid" do
    new_kronos(2005, 6, 31).valid?.should be_false
  end

  it "February 29, 2008 is valid" do
    new_kronos(2008, 2, 29).valid?.should be_true
  end

  it "February 29, 2010 is invalid" do
    new_kronos(2010, 2, 29).valid?.should be_false
  end

end
