=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

module M26

  class PaceCalculator

    include M26::Constants

    attr_accessor :distance, :time, :speed, :ckpts_str

    def initialize(d, t, ckpts_str='')
      @distance  = d
      @time      = t
      @ckpts_str = ckpts_str
      @speed     = Speed.new(@distance, @time);
    end

    public

    def get_summary_line
      mph = sprintf("%2.4f", @speed.get_mph)
      "#{@distance.value} #{@distance.uom}, #{@time.as_hhmmss}, #{@time.secs.to_i} sec, #{@speed.pace_per_mile} ppm, #{mph} mph"
    end

    def get_split_line
      "#{@distance.value}, #{@speed.pace_per_mile} ppm"
    end

    def get_summary_html_line
      get_summary_line
     end

    def get_checkpoints(formula='simple')
      array = Array.new
      if @ckpts_str
        distances = @ckpts_str.split
        distances.each { |d|
          dist   = Distance.new(d.to_f, @distance.uom)
          hhmmss = @speed.projected_time(dist, formula);
          hash   = Hash.new('')
          hash['dist'] = dist
          hash['time'] = hhmmss
          array << hash
        }
      end
      array
    end

    def get_checkpoints_hash
      hash = Hash.new("")
      if @ckpts_str
        distances = @ckpts_str.split
        distances.each { |d|
          dist   = Distance.new(d.to_f, @distance.uom)
          hhmmss = @speed.projected_time(dist);
          hash["#{d}"] = hhmmss
        }
      end
      hash
    end

    def subtract(another_instance)
      if (another_instance != nil)
        dist_obj = @distance.subtract(another_instance.distance)
        et_obj   = @time.subtract(another_instance.time)
        PaceCalculator.new(dist_obj, et_obj)
      end
    end

  end

end
