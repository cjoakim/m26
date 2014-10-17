=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC.

=end

module M26

  class AgeGrade

    attr_accessor :age1, :age2

    def initialize(a1, a2)
      @age1, @age2 = a1.to_f, a2.to_f
    end

    public

    def calculate(elapsed_time, formula='maxpulse')
      if formula.to_s == 'maxpulse'
        calculate_maxpulse(elapsed_time)
      else
        nil
      end
    end

    def calculate_maxpulse(elapsed_time)
      p1, p2 = maxpulse1.to_f, maxpulse2.to_f
      ratio  = p1 / p2
      psecs  = ratio * elapsed_time.secs.to_f
      ptime  = M26::ElapsedTime.new(psecs)
      ptime.as_hhmmss
    end

    def maxpulse1
      maxpulse(age1)
    end

    def maxpulse2
      maxpulse(age2)
    end

    def maxpulse(age)
      p = 220.0 - age
      p = 196.0 if p > 196.0  # age 24 is "peak" (220-24=196)
      p = 1.0   if p < 1
      p
    end
  end

end
