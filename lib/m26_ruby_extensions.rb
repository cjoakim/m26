=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

class Float

  def approximate?(val, tolerance=0.0001)
    if val != nil
      return false  if (self) > val + tolerance
      return false  if (self) < val - tolerance
    else
      return false
    end
    true
  end

end
