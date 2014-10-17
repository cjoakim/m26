=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

require 'spec_helper'

describe "Test class M26::ElapsedTime" do

  before :all do
    $numeric_test_cases = Hash.new
    $string_test_cases  = Hash.new

    cases = Array.new
    cases << "0|00:00:00.00"
    cases << "7|00:00:07.00"
    cases << "59|00:00:59.00"
    cases << "60|00:01:00.00"
    cases << "13650|03:47:30.00"

    cases.each { | tc |
      tokens = tc.split('|')
      $numeric_test_cases["#{tokens[0]}"] = "#{tokens[1]}"
      $string_test_cases["#{tokens[1]}"]  = "#{tokens[0]}"
    }
  end

  it "should construct with an Integer" do
    $numeric_test_cases.keys.sort.each { | seconds_str |
      expected = $numeric_test_cases[seconds_str]
      @et = M26::ElapsedTime.new(seconds_str.to_i)
      @et.as_hhmmss.should == expected

      tokens = @et.as_hhmmss.split(':')
      tokens.size.should == 3
      @et.hh.should == tokens[0].to_i
      @et.mm.should == tokens[1].to_i
      @et.ss.should == tokens[2].to_i
    }
  end

  it "should construct with a Float" do
    $numeric_test_cases.keys.sort.each { | seconds_str |
      expected = $numeric_test_cases[seconds_str]
      @et = M26::ElapsedTime.new(seconds_str.to_f)
      @et.as_hhmmss.should == expected

      tokens = @et.as_hhmmss.split(':')
      tokens.size.should == 3
      @et.hh.should == tokens[0].to_i
      @et.mm.should == tokens[1].to_i
      @et.ss.should == tokens[2].to_i
    }
  end

  it "should construct with a fractional Float" do
    @et = M26::ElapsedTime.new(28872.345)
    @et.as_hhmmss.should    == '08:01:12.35'
    @et.as_hhmmss(3).should == '08:01:12.345'
  end

  it "should construct with a 'HH:MM:SS' String" do
    $string_test_cases.keys.sort.each { | hhmmss_str |
      expected = $string_test_cases[hhmmss_str].to_i
      @et = M26::ElapsedTime.new(hhmmss_str)
      @et.secs.should == expected

      tokens = hhmmss_str.split(':')
      tokens.size.should == 3
      @et.hh.should == tokens[0].to_i
      @et.mm.should == tokens[1].to_i
      @et.ss.should == tokens[2].to_i
    }
  end

  it "should construct with a 'H:MM:SS.FF' String" do
    et = M26::ElapsedTime.new('3:47:23.45')
    et.secs.should be_within(0.001).of(13643.45)

    et = M26::ElapsedTime.new('3:47:23.55')
    et.secs.should be_within(0.001).of(13643.55)
  end

  it "should construct with a 'MM:SS' String" do
    et = M26::ElapsedTime.new('37:23')
    expected = (37 * 60) + 23
    et.secs.should be_within(0.001).of(expected)
  end

  it "should construct and round with a 'SS.FF' String" do
    @et = M26::ElapsedTime.new('91.08')
    @et.secs.should == 91.08

    @et = M26::ElapsedTime.new('91.78')
    @et.secs.should == 91.78
  end

  it "should work for Usain Bolt" do
    et = M26::ElapsedTime.new('0:9.58')
    et.secs.should be_within(0.001).of(9.58)
    et.as_hhmmss.should == "00:00:09.58"
  end

  it "should return as_hours as a Float" do
    @et1 = M26::ElapsedTime.new('3:45:00')
    @et2 = M26::ElapsedTime.new('3:00:00')
    @et1.as_hours.approximate?(3.75).should == true
    @et2.as_hours.approximate?(3.00).should == true
  end

  it "should implement 'to_s'" do
    expected = 'ElapsedTime: hh=3 mm=58 ss=33.0 secs=14313.0 as_hours=3.9758333333333336 as_hhmmss=03:58:33.00'
    M26::ElapsedTime.new('3:58:33').to_s.should == expected
  end

  it "should implement 'print_string'" do
    expected = 'ElapsedTime: hh=3 mm=45 ss=0.0 secs=13500.0 as_hours=3.75 as_hhmmss=03:45:00.00 13500.0 3.75'
    M26::ElapsedTime.new('3:45:00').print_string.should == expected
  end

  it "should subtract" do
    @et1 = M26::ElapsedTime.new('3:48:16')
    @et2 = M26::ElapsedTime.new('3:47:30')
    @et3 = M26::ElapsedTime.new('3:00:00')

    @diff1 = @et1.subtract(@et2)
    @diff1.instance_of?(M26::ElapsedTime).should == true
    @diff1.as_hhmmss.should == '00:00:46.00'

    @diff2 = @et1.subtract(@et3)
    @diff2.as_hhmmss.should == '00:48:16.00'
  end
end
