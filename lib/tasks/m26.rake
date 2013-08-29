=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

require 'm26'

desc 'Build the gem, then unpack and validate it'
task :build do
  filename = "m26-#{M26::Constants::VERSION}.gem"
  dirname  = "m26-#{M26::Constants::VERSION}"

  puts "Removing #{filename} ..."
  `rm  build/#{filename}`

  puts "Building #{filename} ..."
  `gem build m26.gemspec`

  puts "Copying gem to build dir ..."
  `cp  #{filename} build/`

  puts "Moving the unpack directory #{dirname} ..."
  `rm -rf build/#{dirname}`

  puts "Unpacking the gem ..."
  `gem unpack build/#{filename} --target build/`
end

desc 'Push the gem to RubyGems.org'
task :push do
  filename = "m26-#{M26::Constants::VERSION}.gem"
  `gem push #{filename}`
end

desc 'Calculate Pace-per-Mile, etc from a given distance and time'
task :qif2delim do
  d = command_line_arg('d', nil)
  t = command_line_arg('t', nil)
  u = command_line_arg('u', 'm')
  # TODO
end

desc 'Display the Array of leap years'
task :display_leap_years do
  puts M26::Age.new('1958-10-07', '2013-08-29').leap_years.inspect
end
