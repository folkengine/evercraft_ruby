require 'evercraft'
require_relative '../test_helper'

class TestRoguesGallery < Minitest::Test
  include Evercraft

  def test_description
    description = 'My rogues gallery'
    gallery = RoguesGallery.new('My rogues gallery')
    assert_equal gallery.description, description
  end

  def test_add_character_same_name_throws_error
    char1 = Character.new('foo')
    char2 = Character.new('foo')
    gallery = RoguesGallery.new('My rogues gallery')
    assert_raises(CharacterStateException) do
      gallery.add([char1, char2])
    end
  end
end
