=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

module M26

  class ElapsedTime

    include M26::Constants

    attr_accessor :hh, :mm, :ss, :secs

    public

    def initialize(raw_val)
      @hh, @mm, @ss = 0, 0, 0.0;
      if (raw_val.kind_of? String)
        initialize_string(raw_val)
      else
        initialize_number(raw_val)
      end
    end

    def as_hours
      @secs / SECONDS_PER_HOUR.to_f
    end

    def as_hhmmss(ss_fractional_digits=2)
      return "#{zero_pad(hh)}:#{zero_pad(mm)}:#{zero_pad(ss, ss_fractional_digits)}"
    end

    def subtract(another_instance)
      h1 = as_hours
      h2 = another_instance.as_hours
      h3 = h1 - h2
      ElapsedTime.new(h3 * SECONDS_PER_HOUR)
    end

    def to_s
      return "ElapsedTime: hh=#{hh} mm=#{mm} ss=#{ss} secs=#{secs} as_hours=#{as_hours()} as_hhmmss=#{as_hhmmss}"
    end

    def print_string
      return to_s << " #{secs} #{as_hours}"
    end

    private

    def initialize_string(raw_val)
      array = raw_val.strip.split(':');
      if (array.length == 3)
        @hh = array[0].to_i
        @mm = array[1].to_i
        @ss = array[2].to_f
        @ss = 59.999 if @ss > 59
      end

      if (array.length == 2)
        @mm = array[0].to_i
        @ss = array[1].to_f
        @ss = 59.000 if @ss > 59
      end

      if (array.length == 1)
        @ss = array[0].to_f
      end

      @secs = (hh.to_i * SECONDS_PER_HOUR) + (mm.to_i * 60) + ss;
    end

    def initialize_number(raw_val)
      @secs = raw_val
      @hh = (@secs / SECONDS_PER_HOUR).to_i
      rem = @secs - (@hh * SECONDS_PER_HOUR)
      @mm = (rem / 60).to_i
      @ss = rem - (@mm * 60) # .to_i
      @ss = 59.999 if @ss > 59
    end

    def zero_pad(val, fractional_digits=0)
      fmt = "%2.#{fractional_digits}f"
      vvv = sprintf(fmt, val).tr(' ','')
      if (val < 10)
        return '0' + vvv # val.to_s
      else
        return '' + vvv # val.to_s
      end
    end

  end

end
