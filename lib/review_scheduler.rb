# Determines next interval based on time inputs and a schedule lookup list.
class ReviewScheduler
  # Returns an Array of Fixnum representing a set of fixed review delays in
  # seconds. Used for determining when to review next based on time since last
  # review.
  def self.intervals
    [ 0, 5, 25, 120, 600, 3600, 18000, 86400,
      432000, 2160000, 10368000, 62208000 ]
  end

  # Returns Time representing the number of seconds until the next review.
  # (Time) previous: The last time the user scored correctly
  # (Time)  current: The time of the current review
  # (Time|Nil) time: Leave blank unless you are performing a calculation
  # retroactively or are unit testing.
  def self.calculate(previous, current, time = Time.now)
    time + self.intervals.find{ |num| num > (current - previous) }
  end
end