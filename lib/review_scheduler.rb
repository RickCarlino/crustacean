# Determines next interval based on time inputs and a schedule lookup list.
class ReviewScheduler
  def self.intervals # In seconds
    [ 0, 5, 25, 120, 600, 3600, 18000, 86400,
      432000, 2160000, 10368000, 62208000 ]
  end

  # Returns Time representing the number of seconds until the next review.
  # (Time) Previous: The last time the user scored correctly
  # (Time) Current:  The time of the current review
  def self.calculate(previous, current, time = Time.now)
    time + self.intervals.find{ |num| num > (current - previous) }
  end
end