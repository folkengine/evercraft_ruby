require 'evercraft'
require_relative '../test_helper'

class TestCharacter < Minitest::Test
  include Evercraft

  def test_character_name
    myname = 'Foobarian'
    character = Character.new(myname)
    assert_equal(myname, character.character_name)
  end

  def test_invalid_character_name_throws_exception
    assert_raises(CharacterStateException) do
      myname = 'Lorthar!$$'
      Character.new(myname)
    end
  end
end
