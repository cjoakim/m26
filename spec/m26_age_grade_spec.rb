=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

describe "Test class M26::AgeGrade" do

  it "should have a constructor method with integer two ages" do
    ag = M26::AgeGrade.new(56, 41)
    ag.age1.should == 56
    ag.age2.should == 41
  end

  it "should calculate maxpulse" do
    ag = M26::AgeGrade.new(56, 41)
    ag.maxpulse1.should == 164
    ag.maxpulse2.should == 179

    ag.maxpulse(0).should  == 196
    ag.maxpulse(20).should == 196
    ag.maxpulse(300).should == 1
  end

  it "should predict to a younger age" do
    et = M26::ElapsedTime.new('04:08:19')
    ag = M26::AgeGrade.new(56, 41)
    hhmmss = ag.predict(et)
    hhmmss.should == '03:47:30'
  end

  it "should predict to an older age" do
    et = M26::ElapsedTime.new('03:47:30') # 13650 secs
    ag = M26::AgeGrade.new(41, 56)
    hhmmss = ag.predict(et)
    hhmmss.should == '04:08:18' # 14808
  end

  it "should predict to the same age" do
    et = M26::ElapsedTime.new('03:47:30')
    ag = M26::AgeGrade.new(41, 41)
    hhmmss = ag.predict(et)
    hhmmss.should == '03:47:30'
  end

  it "should predict equivalent values from ages under 25" do
    et  = M26::ElapsedTime.new('03:30:00')
    ag1 = M26::AgeGrade.new(19, 55)
    ag2 = M26::AgeGrade.new(24, 55)
    hhmmss1 = ag1.predict(et)
    hhmmss2 = ag2.predict(et)
    hhmmss1.should == hhmmss2
    hhmmss2.should == '04:09:27'
  end

end
