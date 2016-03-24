require 'evercraft'
require_relative '../test_helper'

class TestCharacter < Minitest::Test
  def test_character
    refute_empty(Evercraft::VERSION)
  end
end
