require 'test_helper'

class FactTest < ActiveSupport::TestCase
  def fact
    topic.facts.first
  end
end
