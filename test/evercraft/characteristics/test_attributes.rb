require_relative '../../test_helper'

class TestAttributes < Minitest::Test
  include Evercraft

  def test_test_factory
    attr = Attributes.test_factory
    # strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma
    assert attr.strength > 3
    assert attr.dexterity > 3
    assert attr.constitution > 3
    assert attr.wisdom > 3
    assert attr.intelligence > 3
    assert attr.charisma > 3
  end
end
