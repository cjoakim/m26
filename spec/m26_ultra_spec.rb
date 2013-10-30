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
    rt   = M26::ElapsedTime.new('00:09:00')
    rs   = M26::Speed.new(mile, rt)
    wt   = M26::ElapsedTime.new('00:17:00')
    ws   = M26::Speed.new(mile, rt)
    sth  = M26::ElapsedTime.new('00:06:00')
    ds   = '26.2,31.0,40.0'
    u    = M26::Ultra.new(rt, rs, wt, ws, sth, ds)
    puts u.inspect
  end

end
