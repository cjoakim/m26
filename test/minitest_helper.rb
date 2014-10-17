
$LOAD_PATH.each_with_index { | path, idx |
  # puts "LOAD_PATH #{idx} #{path}"
}

require 'rubygems'
require 'simplecov'

SimpleCov.start do
  add_filter "/task/"
  add_filter "/spec/"
  add_filter "/test/"
  # add_group "lib", "lib/"
end

require 'm26'
