require_relative '../../test_helper'

class TestAlignment < Minitest::Test
  include Evercraft
  def test_parse
    assert_equal Alignment::EVIL, Alignment.parse('evil')
    assert_equal Alignment::GOOD, Alignment.parse('good')
  end
end
