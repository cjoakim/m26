=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

module M26

  class Age
    @@leap_years = []

    attr_accessor :dob, :as_of_date, :yymm, :days, :whole_years, :float_years

    def self.leap_years
      @@leap_years
    end

    # TODO - move these two methods down
    def leap_years
      @@leap_years
    end

    def to_s
      "Age - dob: #{dob} as_of: #{as_of_date } days: #{days} whole: #{whole_years} float: #{float_years} mp: #{max_pulse}"
    end

    def initialize(birth_yyyy_mm_dd, as_of_yyyy_mm_dd)
      initialize_leap_years if @@leap_years.size == 0
      @dob = Date.parse(birth_yyyy_mm_dd)
      @as_of_date = Date.parse(as_of_yyyy_mm_dd)
      @days = as_of_date - dob
      @yymm = (dob.mon * 100) + (dob.day)

      if relation_to_birthday < 0
        @whole_years = as_of_date.year - dob.year - 1
      else
        @whole_years = as_of_date.year - dob.year
      end

      pbd, nbd = prev_birthday, next_birthday
      ndays = (leap_year?(nbd.year) ? 366 : 365)
      days_diff = as_of_date - pbd
      if relation_to_birthday == 0
        @float_years = @whole_years.to_f
      else
        @float_years = @whole_years.to_f + (days_diff.to_f / ndays.to_f)
      end
    end

    def initialize_leap_years
      (1900..2100).to_a.each { | y |
        d = Date.parse("#{y}-01-01")
        @@leap_years << y if d.leap?
      }
    end

    def leap_year?(y)
      @@leap_years.include?(y)
    end

    def next_birthday
      bb = relation_to_birthday
      if bb >= 0
        Date.parse("#{as_of_date.year + 1}-#{dob_mm_dd}")
      else
        Date.parse("#{as_of_date.year}-#{dob_mm_dd}")
      end
    end

    def prev_birthday
      bb = relation_to_birthday
      if bb > 0
        Date.parse("#{as_of_date.year}-#{dob_mm_dd}")
      else
        Date.parse("#{as_of_date.year - 1}-#{dob_mm_dd}")
      end
    end

    def dob_mm_dd
      "#{dob.month}-#{dob.mday}"
    end

    def to_f
      float_years # TODO - test
    end

    def max_pulse
      if float_years <= 20
        200.0
      else
        220.0 - float_years
      end
    end

    private

    # return -1 (before), 0 (on), or 1 (after)
    def relation_to_birthday
      if as_of_date.mon < dob.mon
        return -1
      elsif as_of_date.mon == dob.mon
        if as_of_date.mday < dob.mday
          return -1
        end
        if as_of_date.mday == dob.mday
          return 0
        end
      end
      1
    end

  end

end
