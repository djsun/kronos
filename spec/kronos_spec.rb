require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kronos" do
  
  it "15-Mar-2001" do
    c = Kronos.parse("15-Mar-2001")
    c.year.should  == 2001
    c.month.should == 3
    c.day.should   == 15
    c.to_hash.should == {
      'year'  => 2001,
      'month' => 3,
      'day'   => 15,
    }
  end
  
  it "January 1976" do
    c = Kronos.parse("January 1976")
    c.year.should  == 1976
    c.month.should == 1
    c.day.should   == nil
    c.to_hash.should == {
      'year'  => 1976,
      'month' => 1,
    }
  end

  it "1991" do
    c = Kronos.parse("1991")
    c.year.should  == 1991
    c.month.should == nil
    c.day.should   == nil
    c.to_hash.should == {
      'year'  => 1991,
    }
  end

  it "91" do
    c = Kronos.parse("91")
    c.year.should  == 1991
    c.month.should == nil
    c.day.should   == nil
    c.to_hash.should == {
      'year'  => 1991,
    }
  end

  it "'91" do
    c = Kronos.parse("'91")
    c.year.should  == 1991
    c.month.should == nil
    c.day.should   == nil
    c.to_hash.should == {
      'year'  => 1991,
    }
  end

  it "2019" do
    c = Kronos.parse("2019")
    c.year.should  == 2019
    c.month.should == nil
    c.day.should   == nil
    c.to_hash.should == {
      'year'  => 2019,
    }
  end

  it "19" do
    c = Kronos.parse("19")
    c.year.should  == 2019
    c.month.should == nil
    c.day.should   == nil
    c.to_hash.should == {
      'year'  => 2019,
    }
  end

  it "'19" do
    c = Kronos.parse("'19")
    c.year.should  == 2019
    c.month.should == nil
    c.day.should   == nil
    c.to_hash.should == {
      'year'  => 2019,
    }
  end
  
  it "1/17/2007" do
    c = Kronos.parse("1/17/2007")
    c.year.should  == 2007
    c.month.should == 1
    c.day.should   == 17
    c.to_hash.should == {
      'year'  => 2007,
      'month' => 1,
      'day'   => 17,
    }
  end
  
  it "Aug-96" do
    c = Kronos.parse("Aug-96")
    c.year.should  == 1996
    c.month.should == 8
    c.day.should   == nil
    c.to_hash.should == {
      'year'  => 1996,
      'month' => 8,
    }
  end

  it "15-Mar-96" do
    c = Kronos.parse("15-Mar-96")
    c.year.should  == 1996
    c.month.should == 3
    c.day.should   == 15
    c.to_hash.should == {
      'year'  => 1996,
      'month' => 3,
      'day'   => 15,
    }
  end
  
  it "empty string" do
    c = Kronos.parse("")
    c.year.should  == nil
    c.month.should == nil
    c.day.should   == nil
    c.to_hash.should == {}
  end

  it "unknown" do
    c = Kronos.parse("unknown")
    c.year.should  == nil
    c.month.should == nil
    c.day.should  == nil
    c.to_hash.should == {}
  end
  
end
