=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

rspec spec/m26_ultra_spec.rb

=end

require 'spec_helper'

describe "Test class M26::Ultra" do

  before :all do
  end

  it "should work with non-stop running" do
    rp  = M26::ElapsedTime.new('00:08:00')
    rt  = M26::ElapsedTime.new('00:60:00')
    wp  = M26::ElapsedTime.new('00:17:00')
    wt  = M26::ElapsedTime.new('00:00:00')
    sth = M26::ElapsedTime.new('00:00:00')
    u   = M26::Ultra.new(rp, rt, wp, wt, sth)
    u.overall_speed.get_mph.should be_within(0.01).of(7.5)
  end

  it "should work with non-stop running or walking" do
    rp  = M26::ElapsedTime.new('00:08:00')
    rt  = M26::ElapsedTime.new('00:04:00')
    wp  = M26::ElapsedTime.new('00:16:00')
    wt  = M26::ElapsedTime.new('00:04:00')
    sth = M26::ElapsedTime.new('00:00:00')
    u   = M26::Ultra.new(rp, rt, wp, wt, sth)
    u.overall_speed.get_mph.should be_within(0.01).of(5.0)
  end

  it "should work with non-stop running or walking, with breaks" do
    rp  = M26::ElapsedTime.new('00:08:00')
    rt  = M26::ElapsedTime.new('00:04:00')
    wp  = M26::ElapsedTime.new('00:16:00')
    wt  = M26::ElapsedTime.new('00:04:00')
    sth = M26::ElapsedTime.new('00:15:00')
    u   = M26::Ultra.new(rp, rt, wp, wt, sth)
    u.overall_speed.get_mph.should be_within(0.01).of(5.0 * 0.75)
  end

  it "should work with non-stop running or walking, with quick breaks" do
    rp  = M26::ElapsedTime.new('00:08:00') # running pace-per-mile
    rt  = M26::ElapsedTime.new('00:04:00') # running segment time
    wp  = M26::ElapsedTime.new('00:16:00') # walking pace-per-mile
    wt  = M26::ElapsedTime.new('00:04:00') # walking segment time
    sth = M26::ElapsedTime.new('00:03:00') # rest/stopped time per hour
    u   = M26::Ultra.new(rp, rt, wp, wt, sth)
    u.overall_speed.get_mph.should be_within(0.01).of(5.0 * 0.95)
  end

end
