=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

describe "Test class M26::Constants" do

  it "should have the correct version-related values" do
    M26::Constants::VERSION.should == '0.3.0'
    M26::Constants::DATE.should    == '2013-10-13'
  end

end