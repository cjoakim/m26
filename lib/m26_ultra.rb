=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

module M26

  class Ultra

    attr_accessor :run_time, :run_speed, :walk_time, :walk_speed, :stopped_time_per_hour
    attr_accessor :distances, :stopped_time_pct, :moving_time_pct
    attr_accessor :stopped_time_pct, :moving_time_pct
    attr_accessor :total_moving_time, :run_time_pct, :walk_time_pct

    attr_accessor :run_spm, :walk_spm

    def initialize(rt, rs, wt, ws, sth, distances_str)
      @run_time, @run_speed, @walk_time, @walk_speed, @stopped_time_per_hour = rt, rs, wt, ws, sth
      @distances = distances_str.split(',')

      if stopped_time_per_hour
        @stopped_time_pct = stopped_time_per_hour.secs.to_f / M26::Constants::SECONDS_PER_HOUR.to_f
        @moving_time_pct  = 100.0 - stopped_time_pct
      else
        @stopped_time_pct = 0.0
        @moving_time_pct  = 100.0
      end

      @total_moving_time = (run_time.secs.to_f + walk_time.secs.to_f).to_f
      @run_time_pct  = (run_time.secs.to_f)  / total_moving_time
      @walk_time_pct =  1.0 - run_time_pct

      # calculate seconds per mile (spm)
      # @run_spm   = run_speed.seconds_per_mile.to_f * run_time_pct
      # @walk_spm  = walk_speed.seconds_per_mile.to_f * walk_time_pct
      # @total_spm = run_spm + walk_spm

      # @tpm   = ElapsedTime.new(@spm)
      # @speed = Speed.new(Distance.new(1.0), @tpm)
      # hash = @speed.projected_times('26.2')

      # if true
      #   puts "run:  #{@speed1.pace_per_mile} pace,  #{@speed1.get_mph} mph,  #{t1.as_hhmmss},  #{@speed1_pct * 100.0}%"
      #   puts "walk: #{@speed2.pace_per_mile} pace,  #{@speed2.get_mph} mph,  #{t2.as_hhmmss},  #{@speed2_pct * 100.0}%"
      #   puts "avg:  #{@speed.pace_per_mile} pace,  #{@speed.get_mph} mph"
      #   distances.each { | d |
      #     time = @speed.projected_time(Distance.new(d.to_f))
      #     puts "projected time for #{d} miles = #{time}"
      #   }
      # end
    end

    def average_pace_per_mile
      "#{@tpm.as_hhmmss}"
    end

  end

end
