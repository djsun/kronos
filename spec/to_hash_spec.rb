require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "to_hash" do

  def new_kronos(year=nil, month=nil, day=nil)
    k = Kronos.new
    k.year  = year if year
    k.month = month if month
    k.day   = day if day
    k
  end

  it "2007-1-17" do
    new_kronos(2007, 1, 17).to_hash.should == {
      'year'  => 2007,
      'month' => 1,
      'day'   => 17,
    }
  end

  it "1996-8" do
    new_kronos(1996, 8).to_hash.should == {
      'year'  => 1996,
      'month' => 8,
    }
  end

  it "1980" do
    new_kronos(1980).to_hash.should == {
      'year'  => 1980,
    }
  end

  it "nil, nil, nil" do
    lambda do
      new_kronos(nil, nil, nil).to_hash.should raise(Kronos::Invalid)
    end
  end

  it "nil, 7" do
    lambda do
      new_kronos(nil, 7).to_hash.should raise(Kronos::Invalid)
    end
  end

end
