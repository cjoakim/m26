=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

describe "Test class M26::Constants" do

  it "should have the correct version-related values" do
    M26::Constants::VERSION.should == '1.0.1'
    M26::Constants::DATE.should    == '2014-10-17'
    M26::Constants::EMAIL.should   == 'christopher.joakim@gmail.com'
  end

end
