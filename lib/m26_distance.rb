=begin

Copyright (C) 2013 Chris Joakim, JoakimSoftware LLC

=end

module M26

  class Distance

    include M26::Constants

    attr_accessor :value, :uom

    def initialize(v, um=UOM_MILES)
      @value = v.to_f
      @uom   = um
    end

    public

    def get_miles
      case @uom
        when UOM_MILES
          return @value
        when UOM_KILOMETERS
          return @value / KILOMETERS_PER_MILE
        when UOM_YARDS
          return @value / YARDS_PER_MILE
      end
    end

    def get_kilometers
      case @uom
      when UOM_MILES
        return @value * KILOMETERS_PER_MILE
      when UOM_KILOMETERS
        return @value
      when UOM_YARDS
        return (@value / YARDS_PER_MILE) / MILES_PER_KILOMETER
      end
    end

    def get_yards
      case @uom
      when UOM_MILES
        return @value * YARDS_PER_MILE
      when UOM_KILOMETERS
        return (@value * MILES_PER_KILOMETER) * YARDS_PER_MILE
      when UOM_YARDS
        return @value
      end
    end

    def subtract(another_instance)
      if (another_instance != nil)
        Distance.new(@value - another_instance.value, @uom)
      else
        nil
      end
    end

    def valid?
      return false if @value == nil
      return false if @value < 0
      return true  if @uom == UOM_MILES
      return true  if @uom == UOM_KILOMETERS
      return true  if @uom == UOM_YARDS
      false
    end

    def to_s
      return "Distance: #{@value} #{@uom}"
    end

    def print_string
      return to_s << " #{get_miles()} #{get_kilometers()} #{get_yards()}"
    end

  end

end
