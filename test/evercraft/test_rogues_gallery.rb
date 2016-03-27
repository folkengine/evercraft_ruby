require_relative '../test_helper'

class TestRoguesGallery < Minitest::Test
  include Evercraft

  def test_description
    description = 'My rogues gallery'
    gallery = RoguesGallery.new('My rogues gallery')
    assert_equal gallery.title, description
  end

  def test_add_character_same_name_throws_error
    rogues = [Character.new(character_name: 'foo'), Character.new(character_name: 'foo')]
    gallery = RoguesGallery.new('Another rogues gallery')
    assert_raises(CharacterStateException) do
      gallery.store(rogues)
    end
  end
end
