=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

require 'spec_helper'

describe "Test class M26::Distance" do

  before :all do
  end

  before :each do  # :each is the default 'before' value
  end

  after :each do
  end

  after :all do
  end

  it "should assume miles as UOM" do
    @d = M26::Distance.new(26.2)
    @d.should be_valid
    @d.should_not be_an_instance_of String
    @d.should be_an_instance_of M26::Distance
    @d.uom.should eql('m')
  end

  it "should return its value" do
    @d = M26::Distance.new(26.2)
    @d.value.should == 26.2
  end

  it "should convert from miles" do
    @d = M26::Distance.new(6.20)
    @d.should be_valid
    @d.get_miles.should be_within(0.001).of(6.2)
    @d.get_kilometers.should be_within(0.001).of(10.0)
    @d.get_yards.should be_within(0.001).of(10912.0)

    @d = M26::Distance.new(6.20, 'm')
    @d.should be_valid
    @d.get_miles.should be_within(0.001).of(6.2)
    @d.get_kilometers.should be_within(0.001).of(10.0)
    @d.get_yards.should be_within(0.001).of(10912.0)
  end

  it "should convert from kilometers" do
    @d = M26::Distance.new(10.0, 'k')
    @d.should be_valid
    @d.get_miles.should be_within(0.001).of(6.2)
    @d.get_kilometers.should be_within(0.001).of(10.0)
    @d.get_yards.should be_within(0.001).of(10912.0)
  end

  it "should convert from yards" do
    @d = M26::Distance.new(10912.0, 'y')
    @d.should be_valid
    @d.get_miles.should be_within(0.001).of(6.2)
    @d.get_kilometers.should be_within(0.001).of(10.0)
    @d.get_yards.should be_within(0.001).of(10912.0)
  end

  it "should not recognize unknown units of distance" do
    @d = M26::Distance.new(444.44, 'light_years')
    @d.should_not be_valid
  end

  it "should subtract" do
    @d1 = M26::Distance.new(18.0)
    @d2 = M26::Distance.new(26.2)
    @d2.instance_of?(M26::Distance).should == true
    @d2.subtract(@d1).get_miles.should == 8.2
  end

  it "should to_s" do
    @d = M26::Distance.new(26.2)
    @d.to_s.should == 'Distance: 26.2 m'
  end

  it "should print_string" do
    @d = M26::Distance.new(26.2)
    @d.print_string.should == 'Distance: 26.2 m 26.2 42.258064516222 46112.0'
  end

end
