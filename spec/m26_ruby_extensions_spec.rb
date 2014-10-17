=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

require 'spec_helper'

describe "Test extensions to class Float" do

  it "should implement approximate? with default arg values" do
    @f = 3.141592678
    @f.approximate?(3.14).should == false
    @f.approximate?(3.14159).should == true
  end

  it "should implement approximate? with specified tolerance" do
    @f = 3.141592678
    @f.approximate?(3.14, 0.1).should == true
    @f.approximate?(3.14159, 0.00000000001).should == false
    @f.approximate?(12, 0.00000000001).should == false
  end
end
