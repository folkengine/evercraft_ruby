require 'evercraft'
require_relative '../test_helper'

class TestRandomNameGenerator < Minitest::Test
  def test_version
    refute_empty(Evercraft::VERSION)
  end
end
