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

class Gear
  attr_reader :lower_bound, :upper_bound

  def initialize(lower_bound:, upper_bound:)
    @lower_bound = lower_bound
    @upper_bound = upper_bound
  end

  def high_rpm?(rpm)
    rpm > upper_bound
  end

  def low_rpm?(rpm)
    rpm < lower_bound
  end
end

class GearBox
  def initialize(gears)
    raise ArgumentError, "gears must contain at least one gear" if gears.empty?

    @gear_number = 0
    @gears = gears
      .each_with_index
      .each_with_object({}) { |(gear, index), acc| acc[index + 1] = gear }
  end

  def doit(rpm)
    if gear_number.zero?
      start
    elsif current_gear.high_rpm?(rpm) && shift_up?
      shift_up
    elsif current_gear.low_rpm?(rpm) && shift_down?
      shift_down
    else
      # stay on current gear
    end
  end

  # @api private
  def gear_number
    @gear_number
  end

  private

  attr_reader :gears

  def start
    @gear_number = 1
  end

  def shift_up
    @gear_number += 1
  end

  def shift_down
    @gear_number -= 1
  end

  def current_gear
    gears.fetch(gear_number)
  end

  def shift_up?
    gear_number < gears.count
  end

  def shift_down?
    gear_number > 1
  end
end
