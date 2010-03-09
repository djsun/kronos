require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kronos from_hash" do
  
  it "2002" do
    k = Kronos.from_hash({
      'year' => 2002,
    })
    k.year.should == 2002
    k.month.should == nil
    k.day.should == nil
  end

  it "November 2002" do
    k = Kronos.from_hash({
      'year' => 2002,
      'month' => 11,
    })
    k.year.should == 2002
    k.month.should == 11
    k.day.should == nil
  end

  it "November 9, 2002" do
    k = Kronos.from_hash({
      'year' => 2002,
      'month' => 11,
      'day'   => 9,
    })
    k.year.should == 2002
    k.month.should == 11
    k.day.should == 9
  end
  
  it "Malformed: ? 9, 2002" do
    k = Kronos.from_hash({
      'year' => 2002,
      'month' => nil,
      'day'   => 9,
    })
    k.should == nil
  end  
end