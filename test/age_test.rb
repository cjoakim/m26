require_relative "minitest_helper"
require "minitest/autorun"

# see http://www.rubyinside.com/a-minitestspec-tutorial-elegant-spec-style-testing-that-comes-with-ruby-5354.html

describe M26::Age do

  before do
    @one_day = 0.0028 # irb: (1.0/365.0).to_f => 0.0027397260273972603
    @age1 = M26::Age.new('1958-10-07', '2013-08-29')
    @age2 = M26::Age.new('1958-10-07', '2013-10-07')
    @age3 = M26::Age.new('1958-10-07', '2013-11-16')
    @age4 = M26::Age.new('1958-10-07', '2013-10-06')
  end

  it "should implement class method 'leap_years'" do
    leap_years = M26::Age.leap_years
    leap_years.must_be_instance_of(Array)
    leap_years.size.must_equal(49)
    leap_years[0].must_equal(1904)
    leap_years[-1].must_equal(2096)
    leap_years.include?(2013).must_equal(false)
    leap_years.include?(2012).must_equal(true)
  end

  it "should implement instance method 'leap_years'" do
    leap_years = @age1.leap_years
    leap_years.must_be_instance_of(Array)
    leap_years.size.must_equal(49)
    leap_years[0].must_equal(1904)
    leap_years[-1].must_equal(2096)
    leap_years.include?(2013).must_equal(false)
    leap_years.include?(2012).must_equal(true)
  end

  it "should implement getter methods 'dob', 'as_of_date', and dob_mm_dd'" do
    @age1.dob.to_s.must_equal '1958-10-07'
    @age1.as_of_date.to_s.must_equal '2013-08-29'
    @age1.dob_mm_dd.must_equal '10-7'

    @age2.dob.to_s.must_equal '1958-10-07'
    @age2.as_of_date.to_s.must_equal '2013-10-07'
    @age2.dob_mm_dd.must_equal '10-7'

    @age3.dob.to_s.must_equal '1958-10-07'
    @age3.as_of_date.to_s.must_equal '2013-11-16'
    @age3.dob_mm_dd.must_equal '10-7'
  end

  it "should implement method 'next_birthday'" do
    @age1.next_birthday.to_s.must_equal '2013-10-07'
    @age2.next_birthday.to_s.must_equal '2014-10-07'
    @age3.next_birthday.to_s.must_equal '2014-10-07'
  end

  it "should implement method 'prev_birthday'" do
    @age1.prev_birthday.to_s.must_equal '2012-10-07'
    @age2.prev_birthday.to_s.must_equal '2012-10-07'
    @age3.prev_birthday.to_s.must_equal '2013-10-07'
  end

  it "should calculate age in whole years" do
    @age1.whole_years.must_equal 54
    @age2.whole_years.must_equal 55
    @age3.whole_years.must_equal 55
    @age4.whole_years.must_equal 54
  end

  it "should calculate age in float years" do
    @age1.float_years.must_be_close_to 54.893, @one_day
    @age2.float_years.must_be_close_to 55.0,   @one_day
    @age3.float_years.must_be_close_to 55.110, @one_day
    @age4.float_years.must_be_close_to 54.997, @one_day
  end

  it "should implement method 'max_pulse'" do
    @age1.max_pulse.must_be_close_to 165.1, 0.1
    @age2.max_pulse.must_be_close_to 165.0, 0.1
    @age3.max_pulse.must_be_close_to 164.89, 0.1

    youngster = M26::Age.new('1999-12-31', '2013-11-16')
    youngster.max_pulse.must_be_close_to 200.0, 0.1
  end

  it "should implement method 'to_f'" do
    @age1.to_f.must_be_close_to 54.89315068, 0.01
  end

  it "should implement 'to_s'" do
    expected = 'Age - dob: 1958-10-07 as_of: 2013-08-29 days: 20050/1 whole: 54 float: 54.893150684931506 mp: 165.1068493150685'
    @age1.to_s.must_equal expected
  end

end
