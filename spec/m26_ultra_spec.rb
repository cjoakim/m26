=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

rspec spec/m26_ultra_spec.rb

=end

require 'spec_helper'

describe "Test class M26::Ultra" do

  before :all do
  end

  it "should be implemented" do
    mile = M26::Distance.new('1.0')
    rp  = M26::ElapsedTime.new('00:09:00')
    rt  = M26::ElapsedTime.new('00:03:00')
    wp  = M26::ElapsedTime.new('00:17:00')
    wt  = M26::ElapsedTime.new('00:01:00')
    sth = M26::ElapsedTime.new('00:03:00')
    u   = M26::Ultra.new(rp, rt, wp, wt, sth, true)

    six_hour_dist = u.overall_speed.get_mph * 6.0
    puts "six_hour_dist: #{six_hour_dist}"
  end

end
