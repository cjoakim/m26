=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

module M26

  class Speed

    include M26::Constants

    attr_accessor :distance, :elapsed_time
    attr_accessor :evt_age, :base_age, :ag_factor, :ag_secs, :ag_time, :ag_speed

    def initialize(dist, et)
      @distance     = dist
      @elapsed_time = et
      @mph          = 0
    end

    def self.from_pace_per_mile(ppm)
      dist   = Joakim::M26::Distance.new(1.0)
      tokens = ppm.split(':')
      secs   = ((tokens[0].to_i * 60) + tokens[1].to_i).to_f
      et     = Joakim::M26::ElapsedTime.new(secs)
      Joakim::M26::Speed.new(dist, et)
    end

    public

    def get_mph
      num = @distance.get_miles.to_f
      den = @elapsed_time.as_hours
      num / den
    end

    def get_kph
      @distance.get_kilometers / @elapsed_time.as_hours();
    end

    def get_yph
      @distance.get_yards / @elapsed_time.as_hours();
    end

    def pace_per_mile
      spm = seconds_per_mile()
      mm  = (spm / 60).floor;
      ss  = spm - (mm * 60);

      if (ss < 10)
        ss = '0' + ss.to_s;
      else
        ss = '' + ss.to_s;
      end
      ss = ss.slice(0..4)
      return "#{mm}:#{ss}";
    end

    def seconds_per_mile
      @elapsed_time.secs / @distance.get_miles
    end

    def projected_time(another_distance, algorithm='simple', pow=1.06, debug=false)
      if (algorithm == 'riegel')
        t1 = @elapsed_time.secs
        d1 = @distance.get_miles
        d2 = another_distance.get_miles
        t2 = t1.to_f * ((d2.to_f / d1.to_f) ** pow)
        et = ElapsedTime.new(t2);
        return et.as_hhmmss
      else
        projSecs = seconds_per_mile() * another_distance.get_miles();
        et = ElapsedTime.new(projSecs);
        return et.as_hhmmss
      end
    end

    def projected_times(space_delim_distances)
      hash  = Hash.new();
      array = space_delim_distances.split(' ');
      array.each { |d|
        another_distance = Distance.new(d.to_f, "m");
        projSecs = seconds_per_mile() * another_distance.get_miles();
        et = ElapsedTime.new(projSecs);
        hash["#{d}"] = et.as_hhmmss;
      }
      return hash;
    end

    def to_s
      return "Speed: miles=#{@distance.get_miles} seconds=#{@elapsed_time.secs} mph=#{get_mph()} kph=#{get_kph()} yph=#{get_yph()}"
    end

    def age_graded(event_yyyy_mm_dd, base_yyyy_mm_dd=nil)
      @evt_age = Joakim::Age.new event_yyyy_mm_dd
      if base_yyyy_mm_dd.nil?
        @base_age = Joakim::Age.new
      else
        @base_age = Joakim::Age.new base_yyyy_mm_dd
      end
      @ag_factor = (base_age.max_pulse / evt_age.max_pulse).to_f
      @ag_secs   = (elapsed_time.secs.to_f) * ag_factor
      @ag_time   = Joakim::M26::ElapsedTime.new(ag_secs)
      @ag_speed  = Joakim::M26::Speed.new(distance, ag_time)
      if false
        puts "evt age:   #{evt_age.to_s}  #{evt_age.date}"
        puts "base age:  #{base_age.to_s} #{base_age.date}"
        puts "ag_factor: #{ag_factor}"
        puts "ag_secs:   #{ag_secs}"
        puts "ag_speed:  #{ag_speed.to_s}"
        puts "base pace: #{pace_per_mile}"
        puts "base time: #{elapsed_time.as_hhmmss}"
        puts "ag   pace: #{ag_speed.pace_per_mile}"
        puts "ag   time: #{ag_speed.elapsed_time.as_hhmmss}"
      end
      @ag_speed
    end

  end

end
