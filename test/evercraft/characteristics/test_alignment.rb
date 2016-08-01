require_relative '../../test_helper'

class TestAlignment < Minitest::Test
  include Evercraft

  def test_new
    assert_equal 'evil', Alignment.new('evil').to_s
    assert_equal 'evil', Alignment.new(:evil).to_s
    assert_equal 'good', Alignment.new('GOOD').to_s
    assert_equal 'neutral', Alignment.new.to_s
    assert_equal 'neutral', Alignment.new('chipper').to_s
  end

  def test_equals
    assert(Alignment.new('evil').eql?('EVIL'))
    assert(Alignment.new('evil') == 'evil')
  end
end
