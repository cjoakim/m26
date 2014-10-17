=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

require 'm26'

desc 'Execute the README synopsis content'
task :synopsis do
  et = M26::ElapsedTime.new('3:58:33')
  puts "et = M26::ElapsedTime.new('3:58:33')  # works for average marathoners"
  puts "et.as_hours -> #{et.as_hours}         # translates to a Float"
end
