=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

module M26

  class WalkRunPaceCalculator

    include M26::Constants

    attr_accessor :distance, :time, :speed, :distances

    def initialize(s1, s2, t1, t2, distances_str)
      @speed1, @speed2, @etime1, @etime2 = s1, s2, t1, t2
      @total_time = (@etime1.secs + @etime2.secs).to_f
      @speed1_pct = ((@etime1.secs).to_f) / @total_time.to_f
      @speed2_pct = ((@etime2.secs).to_f) / @total_time.to_f

      # calculate seconds per mile (spm)
      @spm1  = ((@speed1.seconds_per_mile).to_f) * @speed1_pct
      @spm2  = ((@speed2.seconds_per_mile).to_f) * @speed2_pct
      @spm   = @spm1 + @spm2
      @tpm   = ElapsedTime.new(@spm)
      @speed = Speed.new(Distance.new(1.0), @tpm)
      hash = @speed.projected_times('26.2')

      if true
        puts "run:  #{@speed1.pace_per_mile} pace,  #{@speed1.get_mph} mph,  #{t1.as_hhmmss},  #{@speed1_pct * 100.0}%"
        puts "walk: #{@speed2.pace_per_mile} pace,  #{@speed2.get_mph} mph,  #{t2.as_hhmmss},  #{@speed2_pct * 100.0}%"
        puts "avg:  #{@speed.pace_per_mile} pace,  #{@speed.get_mph} mph"
        distances_str.split(',').each { | d |
          time = @speed.projected_time(Distance.new(d.to_f))
          puts "projected time for #{d} miles = #{time}"
        }
      end
    end

    def average_pace_per_mile
      "#{@tpm.as_hhmmss}"
    end

    def average_mph
      "#{@speed.get_mph}"
    end

    def get_summary_html_line
      "Average Pace per Mile: #{@tpm.as_hhmmss}  Average MPH: #{@speed.get_mph} "
    end

    def get_checkpoints
      array = Array.new
      if @ckpts_str
        distances = @ckpts_str.split
        distances.each { |d|
          dist   = Distance.new(d.to_f, 'm')
          hhmmss = @speed.projected_time(dist);
          hash   = Hash.new('')
          hash['dist'] = dist
          hash['time'] = hhmmss
          array << hash
        }
      end
      array
    end

  end

end
