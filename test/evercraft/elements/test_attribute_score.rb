require_relative '../../test_helper'

class TestAttributeScore < Minitest::Test
  include Evercraft

  def test_negative_5
    assert_equal AttributeScore.new(1).modifier, -5
  end

  def test_negative_4
    assert_equal AttributeScore.new(2).modifier, -4
    assert_equal AttributeScore.new(3).modifier, -4
  end

  def test_negative_3
    assert_equal AttributeScore.new(4).modifier, -3
    assert_equal AttributeScore.new(5).modifier, -3
  end

  def test_negative_2
    assert_equal AttributeScore.new(6).modifier, -2
    assert_equal AttributeScore.new(7).modifier, -2
  end

  def test_negative_1
    assert_equal AttributeScore.new(8).modifier, -1
    assert_equal AttributeScore.new(9).modifier, -1
  end

  def test_negative_0
    assert_equal AttributeScore.new(10).modifier, 0
    assert_equal AttributeScore.new(11).modifier, 0
  end

  def test_positive_1
    assert_equal AttributeScore.new(12).modifier, 1
    assert_equal AttributeScore.new(13).modifier, 1
  end

  def test_positive_2
    assert_equal AttributeScore.new(14).modifier, 2
    assert_equal AttributeScore.new(15).modifier, 2
  end

  def test_positive_3
    assert_equal AttributeScore.new(16).modifier, 3
    assert_equal AttributeScore.new(17).modifier, 3
  end

  def test_positive_4
    assert_equal AttributeScore.new(18).modifier, 4
    assert_equal AttributeScore.new(19).modifier, 4
  end

  def test_positive_5
    assert_equal AttributeScore.new(20).modifier, 5
  end

  def test_positive_max
    assert_equal AttributeScore.new(200).modifier, 10
  end
end
