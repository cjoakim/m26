=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

def command_line_arg(name, default_value)
  (ENV[name]) ? ENV[name] : default_value
end

def boolean_arg(name)
  val = ENV[name]
  if val
    truthy = %w( y yes t true )
    return true if truthy.include?(val.downcase)
  end
  false
end

def write_file(out_name, content)
  out = File.new out_name, "w+"
  out.write content
  out.flush
  out.close
  puts "file written: #{out_name}"
end

def write_lines(out_name, lines)
  sio = StringIO.new
  lines.each { | line | sio << "#{line}\n" }
  write_file(out_name, sio.string)
end
