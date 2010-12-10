require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "to_s" do

  def new_kronos(year=nil, month=nil, day=nil)
    k = Kronos.new
    k.year  = year if year
    k.month = month if month
    k.day   = day if day
    k
  end

  describe "2005" do
    it "should be '2005'" do
      k = new_kronos(2005)
      k.to_s.should == '2005'
    end
  end

  describe "Feb. 2005" do
    it "should be '2005-02'" do
      k = new_kronos(2005, 2)
      k.to_s.should == '2005-02'
    end
  end

  describe "Feb. 9, 2005" do
    it "should be '2005-02-09'" do
      k = new_kronos(2005, 2, 9)
      k.to_s.should == '2005-02-09'
    end
  end
end
