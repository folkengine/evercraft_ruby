require_relative '../test_helper'

class TestCharacter < Minitest::Test
  include Evercraft

  def test_character_name
    myname = 'Foobarian'
    character = Character.new(character_name: myname)
    assert_equal(myname, character.character_name)
  end

  def test_invalid_character_name_throws_exception
    assert_raises(CharacterStateException) do
      myname = 'Lorthar!$$'
      Character.new(character_name: myname)
    end
  end

  def test_equals
    myname = 'Foobarian'
    character1 = Character.new(character_name: myname)
    character2 = Character.new(character_name: myname)
    assert character1 == character2
  end

  def test_not_equals
    character1 = Character.new(character_name: 'myname')
    character2 = Character.new(character_name: 'my_other_name')
    assert character1 != character2
  end
end
