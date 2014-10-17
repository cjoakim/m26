=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

require 'm26'

desc 'Generate the README synopsis content' # to ensure its validity
task :synopsis do
  puts ""
  puts "== Synopsis"
  puts ""
  puts "  # Units of Measure for Distances"
  puts "    miles = 'm', kilometers = 'k', yards = 'y'"
  puts ""
  puts "  # Distance objects"
  puts "    d = M26::Distance.new(6.20)  # same as the following; defaults to miles"
  puts "    d = M26::Distance.new(6.20, 'm')"
  puts "    d = M26::Distance.new(10.0, 'k')"
  puts "    d = M26::Distance.new(1800, 'y')"
  d = M26::Distance.new(1800, 'y')
  puts "    d.get_miles      -> #{d.get_miles}"
  puts "    d.get_kilometers -> #{d.get_kilometers}"
  puts "    d.get_yards      -> #{d.get_yards}"
  puts ""
  puts "  # ElapsedTime objects - can be constructed from a 'hh:mm:ss' String value"
  et = M26::ElapsedTime.new('3:58:33')
  puts "    et = M26::ElapsedTime.new('3:58:33')  # works for average marathoners"
  puts "    et.as_hours -> #{et.as_hours}         # translates to a Float"
  puts "    et.as_hhmmss -> #{et.as_hhmmss}       # defaults to two decimal positions for the seconds"
  puts ""
  et = M26::ElapsedTime.new('3:58:33.789')
  puts "    et = M26::ElapsedTime.new('3:58:33.789')"
  puts "    et.as_hours -> #{et.as_hours} "
  puts "    et.as_hhmmss -> #{et.as_hhmmss}"
  puts ""
  et = M26::ElapsedTime.new('0:9.58.0008')
  puts "    et = M26::ElapsedTime.new('0:9.58')  # works for Usain Bolt, too"
  puts "    et.as_hours  -> #{et.as_hours} "
  puts ""
  puts "  # ElapsedTime objects - alternatively constructed from a number of total seconds"
  et = M26::ElapsedTime.new(3661.12345)
  puts "    et = M26::ElapsedTime.new(3661.12345)"
  puts "    et.as_hours -> #{et.as_hours}"
  puts "    et.as_hhmmss -> #{et.as_hhmmss}       # defaults to two decimal positions for the seconds"
  puts "    et.as_hhmmss(5) -> #{et.as_hhmmss(5)}    # you can specify the number of decimal positions for the seconds"
  puts ""
  puts "  # Speed objects - constructed from a Distance and ElapsedTime"
  d  = M26::Distance.new(26.20)
  et = M26::ElapsedTime.new('3:58:33')
  s  = M26::Speed.new(d, et)
  puts "    d  = M26::Distance.new(26.20)"
  puts "    et = M26::ElapsedTime.new('3:58:33')"
  puts "    s  = M26::Speed.new(d, et)"
  puts "    s.get_mph -> #{s.get_mph}               # miles per hour "
  puts "    s.get_kph -> #{s.get_kph}               # kilometers per hour "
  puts "    s.get_yph -> #{s.get_yph}               # yards per hour "
  puts "    s.pace_per_mile -> #{s.pace_per_mile}   # pace per mile "

  puts ""
  puts "  # Speed objects - alternatively constructed from a pace-per-mile 'mm:ss' String value"
  s = M26::Speed.from_pace_per_mile('06:00')
  puts "    s = M26::Speed.from_pace_per_mile('06:00')"
  puts "    s.get_mph -> #{s.get_mph}"
  puts "    s.get_kph -> #{s.get_kph}"
  puts "    s.get_yph -> #{s.get_yph}"
  puts "    s.pace_per_mile -> #{s.pace_per_mile}"

  puts ""
  puts "# Projecting a Speed, with simple extrapolation/interpolation"
  d1 = M26::Distance.new(26.2)
  d2 = M26::Distance.new(20.0)
  t  = M26::ElapsedTime.new('03:47:30')
  s  = M26::Speed.new(d1, t)
  puts "    d1 = M26::Distance.new(26.2)"
  puts "    d2 = M26::Distance.new(20.0)"
  puts "    t  = M26::ElapsedTime.new('03:47:30')"
  puts "    s  = M26::Speed.new(d1, t)"
  puts "    s.projected_time(d2) -> #{s.projected_time(d2)}"
  puts ""
  puts "# Projecting a Speed, with pete riegel exponential formula"
  d1 = M26::Distance.new(26.2)
  d2 = M26::Distance.new(20.0)
  t  = M26::ElapsedTime.new('03:47:30')
  s  = M26::Speed.new(d1, t)
  puts "    d1 = M26::Distance.new(26.2)"
  puts "    d2 = M26::Distance.new(20.0)"
  puts "    t  = M26::ElapsedTime.new('03:47:30')"
  puts "    s  = M26::Speed.new(d1, t)"
  puts "    s.projected_time(d2, 'riegel') -> #{s.projected_time(d2, 'riegel')}"
  puts ""
  puts "# Averaging two Speeds, such as for Run-Walk calculations"
  s1  = M26::Speed.from_pace_per_mile('06:00')
  t1  = M26::ElapsedTime.new('00:04:00')
  s2  = M26::Speed.from_pace_per_mile('18:00')
  t2  = M26::ElapsedTime.new('00:04:00')
  avg = M26::Speed.calculate_average_speed(s1, s2, t1, t2)
  puts "    s1  = M26::Speed.from_pace_per_mile('06:00')"
  puts "    t1  = M26::ElapsedTime.new('00:04:00')"
  puts "    s2  = M26::Speed.from_pace_per_mile('18:00')"
  puts "    t2  = M26::ElapsedTime.new('00:04:00')"
  puts "    avg = M26::Speed.calculate_average_speed(s1, s2, t1, t2)"
  puts "    avg.get_mph -> #{avg.get_mph}"
  puts "    avg.pace_per_mile -> #{avg.pace_per_mile}"
  puts ""
  puts "# Age-grading a time to another age"
    et = M26::ElapsedTime.new('04:08:55')
    ag = M26::AgeGrade.new(57.123, 41.789)
  puts "    et = M26::ElapsedTime.new('04:08:55')"
  puts "    ag = M26::AgeGrade.new(57.123, 41.789)"
  puts "    ag.calculate(et) -> #{ag.calculate(et)}"
  puts ""
  puts "# Ultramarathon calculations - run and walk and rest/stopped segments"
  rp  = M26::ElapsedTime.new('00:09:00') # running pace-per-mile
  rt  = M26::ElapsedTime.new('00:04:15') # running segment time
  wp  = M26::ElapsedTime.new('00:16:00') # walking pace-per-mile
  wt  = M26::ElapsedTime.new('00:00:45') # walking segment time
  sth = M26::ElapsedTime.new('00:03:00') # rest/stopped time per hour
  u   = M26::Ultra.new(rp, rt, wp, wt, sth)
  puts "    rp  = M26::ElapsedTime.new('00:08:00') # running pace-per-mile"
  puts "    rt  = M26::ElapsedTime.new('00:04:00') # running segment time"
  puts "    wp  = M26::ElapsedTime.new('00:16:00') # walking pace-per-mile"
  puts "    wt  = M26::ElapsedTime.new('00:04:00') # walking segment time"
  puts "    sth = M26::ElapsedTime.new('00:03:00') # rest/stopped time per hour"
  puts "    u   = M26::Ultra.new(rp, rt, wp, wt, sth)"
  puts "    u.moving_speed.get_mph  -> #{u.moving_speed.get_mph}   # A M26::Speed object is returned reflecting the run & walk"
  puts "    u.overall_speed.get_mph -> #{u.overall_speed.get_mph}  # A M26::Speed object is returned reflecting the run & walk & stops"
  puts ""
end
