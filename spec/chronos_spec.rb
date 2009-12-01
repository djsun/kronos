require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Chronos" do
  
  it "15-Mar-2001" do
    c = Chronos.parse("15-Mar-2001")
    c.year.should  == 2001
    c.month.should == 3
    c.day.should  == 15
  end
  
  it "January 1976" do
    c = Chronos.parse("January 1976")
    c.year.should  == 1976
    c.month.should == 1
    c.day.should   == nil
  end

  it "1991" do
    c = Chronos.parse("1991")
    c.year.should  == 1991
    c.month.should == nil
    c.day.should   == nil
  end

  it "91" do
    c = Chronos.parse("91")
    c.year.should  == 1991
    c.month.should == nil
    c.day.should   == nil
  end

  it "'91" do
    c = Chronos.parse("'91")
    c.year.should  == 1991
    c.month.should == nil
    c.day.should   == nil
  end

  it "2019" do
    c = Chronos.parse("2019")
    c.year.should  == 2019
    c.month.should == nil
    c.day.should   == nil
  end

  it "19" do
    c = Chronos.parse("19")
    c.year.should  == 2019
    c.month.should == nil
    c.day.should   == nil
  end

  it "'19" do
    c = Chronos.parse("'19")
    c.year.should  == 2019
    c.month.should == nil
    c.day.should   == nil
  end
  
  it "1/17/2007" do
    c = Chronos.parse("1/17/2007")
    c.year.should  == 2007
    c.month.should == 1
    c.day.should   == 17
  end
  
  it "" do
    c = Chronos.parse("")
    c.year.should  == nil
    c.month.should == nil
    c.day.should   == nil
  end

  it "unknown" do
    c = Chronos.parse("unknown")
    c.year.should  == nil
    c.month.should == nil
    c.day.should  == nil
  end
  
end
