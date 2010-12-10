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
    new_kronos(2005).valid?.should == true
  end

  it "month and year is valid" do
    new_kronos(2005, 8).valid?.should == true
  end

  it "month, day, and year is valid" do
    new_kronos(2005, 8, 22).valid?.should == true
  end

  it "day and year is invalid" do
    new_kronos(2005, nil, 22).valid?.should == false
  end

  it "nothing is invalid" do
    new_kronos(nil, nil, nil).valid?.should == false
  end

end
