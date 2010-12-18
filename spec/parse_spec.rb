require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kronos" do

  it "1/17/2007" do
    c = Kronos.parse("1/17/2007")
    [c.year, c.month, c.day].should == [2007, 1, 17]
  end

  it "01/17/2007" do
    c = Kronos.parse("01/17/2007")
    [c.year, c.month, c.day].should == [2007, 1, 17]
  end

  it "05/09/2007" do
    c = Kronos.parse("05/09/2007")
    [c.year, c.month, c.day].should == [2007, 5, 9]
  end

  it "05-09-2007" do
    c = Kronos.parse("05-09-2007")
    [c.year, c.month, c.day].should == [2007, 5, 9]
  end

  it "15-Mar-2001" do
    c = Kronos.parse("15-Mar-2001")
    [c.year, c.month, c.day].should == [2001, 3, 15]
  end

  it "30-March-2001" do
    c = Kronos.parse("30-March-2001")
    [c.year, c.month, c.day].should == [2001, 3, 30]
  end

  it "6 Dec 2001" do
    c = Kronos.parse("6 Dec 2001")
    [c.year, c.month, c.day].should == [2001, 12, 6]
  end

  it "23 Jan 23" do
    c = Kronos.parse("23 Jan 23")
    [c.year, c.month, c.day].should == [2023, 1, 23]
  end

  it "23 Jan 1923" do
    c = Kronos.parse("23 Jan 1923")
    [c.year, c.month, c.day].should == [1923, 1, 23]
  end

  it "12 Nov 77" do
    c = Kronos.parse("12 Nov 77")
    [c.year, c.month, c.day].should == [1977, 11, 12]
  end

  it "Nov 12 1977" do
    c = Kronos.parse("Nov 12 1977")
    [c.year, c.month, c.day].should == [1977, 11, 12]
  end

  it "January 1976" do
    c = Kronos.parse("January 1976")
    [c.year, c.month, c.day].should == [1976, 1, nil]
  end

  it "Jun 1976" do
    c = Kronos.parse("Jun 1976")
    [c.year, c.month, c.day].should == [1976, 6, nil]
  end

  it "Jul-71" do
    c = Kronos.parse("Jul-71")
    [c.year, c.month, c.day].should == [1971, 7, nil]
  end

  it "1991" do
    c = Kronos.parse("1991")
    [c.year, c.month, c.day].should == [1991, nil, nil]
  end

  it "91" do
    c = Kronos.parse("91")
    [c.year, c.month, c.day].should == [1991, nil, nil]
  end

  it "'91" do
    c = Kronos.parse("'91")
    [c.year, c.month, c.day].should == [1991, nil, nil]
  end

  it "2019" do
    c = Kronos.parse("2019")
    [c.year, c.month, c.day].should == [2019, nil, nil]
  end

  it "19" do
    c = Kronos.parse("19")
    [c.year, c.month, c.day].should == [2019, nil, nil]
  end

  it "'19" do
    c = Kronos.parse("'19")
    [c.year, c.month, c.day].should == [2019, nil, nil]
  end

  it "Aug-96" do
    c = Kronos.parse("Aug-96")
    [c.year, c.month, c.day].should == [1996, 8, nil]
  end

  it "15-Mar-96" do
    c = Kronos.parse("15-Mar-96")
    [c.year, c.month, c.day].should == [1996, 3, 15]
  end

  it "nil" do
    c = Kronos.parse(nil)
    [c.year, c.month, c.day].should == [nil, nil, nil]
  end

  it "empty string" do
    c = Kronos.parse("")
    [c.year, c.month, c.day].should == [nil, nil, nil]
  end

  it "unknown" do
    c = Kronos.parse("unknown")
    [c.year, c.month, c.day].should == [nil, nil, nil]
  end

  it "prior to 1998" do
    c = Kronos.parse("prior to 1998")
    [c.year, c.month, c.day].should == [nil, nil, nil]
  end

end
