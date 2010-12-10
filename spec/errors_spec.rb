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
    new_kronos(2005).errors.should == []
  end

  it "month and year is valid" do
    new_kronos(2005, 8).errors.should == []
  end

  it "day and year is invalid" do
    errors = new_kronos(2005, nil, 22).errors
    errors.length.should == 1
    errors.should include("if day is given, then month and year must also be given")
  end

  it "nothing is invalid" do
    errors = new_kronos(nil, nil, nil).errors
    errors.length.should == 1
    errors.should include("year must be given")
  end

  it "month, day, and year is valid" do
    new_kronos(2005, 8, 22).errors.should == []
  end

  it "month, day, and year with out-of-range month is invalid" do
    errors = new_kronos(2005, 13, 22).errors
    errors.length.should == 1
    errors.should include("month (13) must be between 1 and 12")
  end

  it "month, day, and year with out-of-range day is invalid" do
    errors = new_kronos(2005, 4, 32).errors
    errors.length.should == 1
    errors.should include("day (32) must be between 1 and 31")
  end

  it "June 0, 2005 is invalid" do
    errors = new_kronos(2005, 6, 0).errors
    errors.length.should == 1
    errors.should include("day (0) must be between 1 and 31")
  end

  it "June 31, 2005 is invalid" do
    errors = new_kronos(2005, 6, 31).errors
    errors.length.should == 1
    errors.should include("date (2005-6-31) must be valid")
  end

  it "February 29, 2008 is valid" do
    new_kronos(2008, 2, 29).errors.should == []
  end

  it "February 29, 2010 is invalid" do
    errors = new_kronos(2010, 2, 29).errors
    errors.length.should == 1
    errors.should include("date (2010-2-29) must be valid")
  end

end
