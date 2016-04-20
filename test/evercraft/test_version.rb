require 'evercraft'
require_relative '../test_helper'

class TestVersion < Minitest::Test
  def test_version
    refute_empty(Evercraft::VERSION)
  end
end
