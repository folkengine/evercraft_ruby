require_relative '../../test_helper'
require 'psych'

class TestRoll < Minitest::Test
  include Evercraft

  def test_18
    roll18 = Roll.new(18)
    assert_equal roll18.to_i, 18
  end

  def test_20
    roll20 = Roll.new(20)
    assert_equal roll20.to_i, 20
  end
end
