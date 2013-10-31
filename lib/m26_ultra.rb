=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

module M26

  class Ultra

    attr_accessor :run_pace, :run_time
    attr_accessor :walk_pace, :walk_time
    attr_accessor :stopped_time_per_hour, :stopped_time_pct, :moving_time_pct
    attr_accessor :moving_secs, :moving_run_pct, :moving_walk_pct
    attr_accessor :run_secs, :walk_secs, :avg_rw_secs
    attr_accessor :moving_speed, :overall_speed

    def initialize(rp, rt, wp, wt, sth=nil, debug=false)
      @run_pace, @run_time = rp, rt
      @walk_pace, @walk_time = wp, wt
      @stopped_time_per_hour = sth
      @overall_mph = 0.0

      if stopped_time_per_hour
        @stopped_time_pct = stopped_time_per_hour.secs.to_f / M26::Constants::SECONDS_PER_HOUR.to_f
        @moving_time_pct  = 1.0 - stopped_time_pct
      else
        @stopped_time_pct = 0.0
        @moving_time_pct  = 1.0
      end

      @moving_secs     = (rt.secs + wt.secs).to_f
      @moving_run_pct  = rt.secs.to_f / moving_secs.to_f
      @moving_walk_pct = 1.0 - moving_run_pct

      @run_secs    = moving_run_pct  * rp.secs
      @walk_secs   = moving_walk_pct * wp.secs
      @avg_rw_secs = (run_secs + walk_secs).to_f

      mile  = M26::Distance.new(1.0)
      mtime = M26::ElapsedTime.new(avg_rw_secs)
      ttime = M26::ElapsedTime.new(avg_rw_secs * (1.0 + stopped_time_pct))
      @moving_speed  = M26::Speed.new(mile, mtime)
      @overall_speed = M26::Speed.new(mile, ttime)

      if debug
        puts "run_pace:         #{run_pace.inspect}"
        puts "run_time:         #{run_time.inspect}"
        puts "walk_pace:        #{walk_pace.inspect}"
        puts "walk_time:        #{walk_time.inspect}"
        puts "stopped_time_pct: #{stopped_time_pct.inspect}"
        puts "moving_time_pct:  #{moving_time_pct.inspect}"
        puts "moving_secs:      #{moving_secs.inspect}"
        puts "moving_run_pct:   #{moving_run_pct.inspect}"
        puts "moving_walk_pct:  #{moving_walk_pct.inspect}"
        puts "run_secs:         #{run_secs.inspect}"
        puts "walk_secs:        #{walk_secs.inspect}"
        puts "avg_rw_secs:      #{avg_rw_secs.inspect}"
        puts "moving_speed:     #{moving_speed}"
        puts "overall_speed:    #{overall_speed}"
      end
    end

    def average_pace_per_mile
      "#{@tpm.as_hhmmss}"
    end

  end

end
