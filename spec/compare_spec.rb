require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kronos Comparisons" do

  def new_kronos(year=nil, month=nil, day=nil)
    k = Kronos.new
    k.year  = year if year
    k.month = month if month
    k.day   = day if day
    k
  end

  describe "2005 vs 2005" do
    before do
      @k1 = new_kronos(2005)
      @k2 = new_kronos(2005)
    end

    it "should not be <" do
      (@k1 < @k2).should == false
    end

    it "should be <=" do
      (@k1 <= @k2).should == true
    end

    it "should be ==" do
      (@k1 == @k2).should == true
    end

    it "should be >=" do
      (@k1 >= @k2).should == true
    end

    it "should not be >" do
      (@k1 > @k2).should == false
    end

  end

  describe "2005 vs 2006" do
    before do
      @k1 = new_kronos(2005)
      @k2 = new_kronos(2006)
    end

    it "should be <" do
      (@k1 < @k2).should == true
    end

    it "should be <=" do
      (@k1 <= @k2).should == true
    end

    it "should not be ==" do
      (@k1 == @k2).should == false
    end

    it "should not be >" do
      (@k1 > @k2).should == false
    end

    it "should not be >=" do
      (@k1 >= @k2).should == false
    end
  end

  describe "March 2005 vs 2006" do
    before do
      @k1 = new_kronos(2005, 3)
      @k2 = new_kronos(2006)
    end

    it "should be <" do
      (@k1 < @k2).should == true
    end

    it "should be <=" do
      (@k1 <= @k2).should == true
    end

    it "should not be ==" do
      (@k1 == @k2).should == false
    end

    it "should not be >" do
      (@k1 > @k2).should == false
    end

    it "should not be >=" do
      (@k1 >= @k2).should == false
    end
  end

  describe "April 2000 vs May 2000" do
    before do
      @k1 = new_kronos(2000, 4)
      @k2 = new_kronos(2000, 5)
    end

    it "should be <" do
      (@k1 < @k2).should == true
    end

    it "should be <=" do
      (@k1 <= @k2).should == true
    end

    it "should not be ==" do
      (@k1 == @k2).should == false
    end

    it "should not be >" do
      (@k1 > @k2).should == false
    end

    it "should not be >=" do
      (@k1 >= @k2).should == false
    end
  end

  describe "April 10, 2000 vs May 1, 2000" do
    before do
      @k1 = new_kronos(2000, 4, 10)
      @k2 = new_kronos(2000, 5, 1)
    end

    it "should be <" do
      (@k1 < @k2).should == true
    end

    it "should be <=" do
      (@k1 <= @k2).should == true
    end

    it "should not be ==" do
      (@k1 == @k2).should == false
    end

    it "should not be >" do
      (@k1 > @k2).should == false
    end

    it "should not be >=" do
      (@k1 >= @k2).should == false
    end
  end

  describe "April 10, 2000 vs May 2000" do
    before do
      @k1 = new_kronos(2000, 4, 10)
      @k2 = new_kronos(2000, 5)
    end

    it "should be <" do
      (@k1 < @k2).should == true
    end

    it "should be <=" do
      (@k1 <= @k2).should == true
    end

    it "should not be ==" do
      (@k1 == @k2).should == false
    end

    it "should not be >" do
      (@k1 > @k2).should == false
    end

    it "should not be >=" do
      (@k1 >= @k2).should == false
    end
  end

  describe "April 10, 2000 vs April 8, 2000" do
    before do
      @k1 = new_kronos(2000, 4, 10)
      @k2 = new_kronos(2000, 4, 8)
    end

    it "should not be <" do
      (@k1 < @k2).should == false
    end

    it "should not be <=" do
      (@k1 <= @k2).should == false
    end

    it "should not be ==" do
      (@k1 == @k2).should == false
    end

    it "should be >" do
      (@k1 > @k2).should == true
    end

    it "should be >=" do
      (@k1 >= @k2).should == true
    end
  end

  describe "(blank) vs 2000" do
    before do
      @k1 = new_kronos()
      @k2 = new_kronos(2000)
    end

    it "should not be <" do
      (@k1 < @k2).should == false
    end

    it "should not be <=" do
      (@k1 <= @k2).should == false
    end

    it "should not be ==" do
      (@k1 == @k2).should == false
    end

    it "should not be >" do
      (@k1 > @k2).should == false
    end

    it "should not be >=" do
      (@k1 >= @k2).should == false
    end
  end
end
