puts "#{__FILE__} #{__LINE__} PID: #{Process.pid}"
$LOAD_PATH.each_with_index { | path, idx |
  # puts "LOAD_PATH #{idx} #{path}"
}

require 'rubygems'
require 'simplecov'

puts "SimpleCov.start in PID: #{Process.pid}"

SimpleCov.start do
  add_filter "/task/"
  add_filter "/spec/"
  add_filter "/test/"
  # add_group "lib", "lib/"
end

require 'm26'

# SimpleCov.at_exit do
#   puts "SimpleCov.at_exit"
#   SimpleCov.result.format!
# end
