
require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_filter "/lib/tasks/"
  add_filter "/spec/"
end

require 'm26'

RSpec.configure do | config |
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def write_file(out_name, content)
  out = File.new out_name, "w+"
  out.write content
  out.flush
  out.close
  puts "file written: #{out_name}"
end

def write_lines(out_name, lines, add_newline=false)
  sio = StringIO.new
  lines.each { | line |
    sio << "#{line}"
    sio << "\n" if add_newline
  }
  write_file(out_name, sio.string)
end
