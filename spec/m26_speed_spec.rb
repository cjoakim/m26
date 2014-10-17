=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

require 'spec_helper'

describe "Test class M26::Speed" do

  before :all do
    @test_cases = Array.new
    @test_cases << "2.0|30:00|4.0|6.45161290324|7040.0|15:00.0|900.0"
    @test_cases << "26.2|03:47:30|6.90989010989011|11.1449840482344|12161.4065934066|8:40.99|520.992366412214"
  end

  it "should construct from a Distance and ElapsedTime, and calculate properly" do
    @test_cases.each { | tc |
      tokens = tc.split('|')
      d = tokens[0].to_f
      t = tokens[1]
      mph = tokens[2].to_f
      kph = tokens[3].to_f
      yph = tokens[4].to_f
      ppm = tokens[5]
      spm = tokens[6].to_f
      @d = M26::Distance.new(d)
      @t = M26::ElapsedTime.new(t)
      @s = M26::Speed.new(@d, @t)
      @s.get_mph.approximate?(mph).should == true
      @s.get_kph.approximate?(kph).should == true
      @s.get_yph.approximate?(yph).should == true
      if (mph > 0)
        @s.pace_per_mile.should == ppm
        @s.seconds_per_mile.approximate?(spm).should == true
      end
    }
  end

  it "should construct from a pace-per-mile, and calculate properly" do
    @s = M26::Speed.from_pace_per_mile('07:54')
    @s.distance.class.name.should == 'M26::Distance'
    @s.distance.uom.should == 'm'
    @s.distance.get_miles.should be_within(0.001).of(1.0)
    @s.elapsed_time.class.name.should == 'M26::ElapsedTime'
    @s.elapsed_time.secs.should == 474
    @s.get_mph.should be_within(0.001).of(7.595)
  end

  it "should implement 'to_s'" do
    @s = M26::Speed.from_pace_per_mile('07:54')
    expected = 'Speed: miles=1.0 seconds=474.0 mph=7.59493670886076 kph=12.249897917544304 yph=13367.088607594938'
    @s.to_s.should == expected
  end

  it "should implement 'projected_times'" do
    @s = M26::Speed.from_pace_per_mile('07:54')
    results = @s.projected_times('2.0 26.2')
    results.size.should == 2
    results.class.name.should == 'Hash'
    results['2.0'].should == '00:15:48.00'
    results['10.0'].should be_nil
    results['26.2'].should == '03:26:58.80'
  end

  it "should project a time with simple extrapolation/interpolation" do
    @d1 = M26::Distance.new(26.2)
    @d2 = M26::Distance.new(20.0)
    @t  = M26::ElapsedTime.new('03:47:30')
    @s  = M26::Speed.new(@d1, @t)
    @s.projected_time(@d2).should == '02:53:39.85'
  end

  it "should project a time with pete riegel exponential formula" do
    @d1 = M26::Distance.new(26.2)
    @d2 = M26::Distance.new(20.0)
    @t  = M26::ElapsedTime.new('03:47:30')
    @s  = M26::Speed.new(@d1, @t)
    @s.projected_time(@d2, 'riegel').should == '02:50:52.39'
  end

  it "should calculate an 'age_graded' speed" do
    @d1 = M26::Distance.new(26.2)
    @d2 = M26::Distance.new(20.0)
    @t  = M26::ElapsedTime.new('03:47:30')
    @s  = M26::Speed.new(@d1, @t)
    @s2 = @s.age_graded('1958-10-07', '2011-08-26','2000-05-28')

    @s.pace_per_mile.should == '8:40.99'
    @s.elapsed_time.as_hhmmss.should == '03:47:30.00'
    @s2.pace_per_mile.should == '9:16.05'
    @s2.elapsed_time.as_hhmmss.should == '04:02:48.54'
  end

  it "should implement 'calculate_average_speed' with even walk/run durations" do
    s1  = M26::Speed.from_pace_per_mile('06:00')
    t1  = M26::ElapsedTime.new('00:04:00')
    s2  = M26::Speed.from_pace_per_mile('18:00')
    t2  = M26::ElapsedTime.new('00:04:00')
    avg = M26::Speed.calculate_average_speed(s1, s2, t1, t2)
    avg.get_mph.should be_within(0.001).of(5.0)
    avg.pace_per_mile.should == '12:00.0'
  end

  it "should implement 'calculate_average_speed' with uneven walk/run durations" do
    s1  = M26::Speed.from_pace_per_mile('09:00')
    t1  = M26::ElapsedTime.new('00:09:00')
    s2  = M26::Speed.from_pace_per_mile('17:00')
    t2  = M26::ElapsedTime.new('00:01:00')
    avg = M26::Speed.calculate_average_speed(s1, s2, t1, t2)
    avg.get_mph.should be_within(0.001).of(6.122)
    avg.pace_per_mile.should == '9:48.0'
  end

  it "should work for Chris Joakim" do
    d  = M26::Distance.new(26.2)
    et = M26::ElapsedTime.new('3:58:33')
    s  = M26::Speed.new(d, et)
    s.get_mph.should be_within(0.0001).of(6.5898)
    s.pace_per_mile.should == '9:06.29'
    s.get_mph.should be_within(0.0001).of(6.5898)
    s.get_kph.should be_within(0.0001).of(10.6287)
    s.get_yph.should be_within(0.001).of(11598.071)
    et.as_hours.should be_within(0.0001).of(3.9758)
  end

  it "should work for Usain Bolt" do
    d  = M26::Distance.new(0.10, 'k')
    et = M26::ElapsedTime.new('0:9.58')
    s  = M26::Speed.new(d, et)
    s.get_mph.should be_within(0.001).of(23.298)
    s.pace_per_mile.should == '2:34.51'
  end

  it "should work for Usain Bolt running a marathon" do
    d  = M26::Distance.new(0.10, 'k')
    et = M26::ElapsedTime.new('0:9.58')
    s  = M26::Speed.new(d, et)
    s.get_mph.should be_within(0.001).of(23.298)
    s.pace_per_mile.should == '2:34.51'
  end
end
