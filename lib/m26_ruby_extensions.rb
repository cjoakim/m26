=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

class Float

  def approximate?(val, tolerance=0.0001)
    return false if (self) > (val + tolerance)
    return false if (self) < (val - tolerance)
    true
  end

end
