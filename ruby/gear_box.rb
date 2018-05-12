# Top Gear Refactoring Kata
# =========================
#
# This is a refactoring challenge where we look at a single-method
# case, which is untested, needs refactoring, and is hard to read. Oh,
# and contains bugs;-)
#
# The assignment is as follows
# ----------------------------
#
# This is the code for our customer's new environmentally friendly electric car.
# The car is very dependent on software for almost everything, and the part that we're
# working on is the automatic gear box. The code you see is the automatic gear box, which
# currently shifts up if the engine goes over 2000 rpm, and down if it goes under 500.
#
# For our this new car, it's been determined that the choice of gear can be much
# more efficient if we could just set more specific ranges of rpm for each gear.
# Future versions of the car could then use actual measurements of fuel consumption
# to configure those ranges on the fly!
# Your assignment is to make the gearbox accept a range of rpms for each gear (and
# of course use that range to shift gears!)
class GearBox
  attr_reader :gear

  def initialize
    @gear = 0
  end

  def doit(rpm)
    if gear.zero?
      start
    elsif high_rpm?(rpm) && shift_up?
      shift_up
    elsif low_rpm?(rpm) && shift_down?
      shift_down
    else
      # stay on current gear
    end
  end

  private

  def start
    @gear = 1
  end

  def shift_up
    @gear += 1
  end

  def shift_down
    @gear -= 1
  end

  def high_rpm?(rpm)
    rpm > 2000
  end

  def low_rpm?(rpm)
    rpm < 500
  end

  def shift_up?
    gear < 6
  end

  def shift_down?
    gear > 1
  end
end
