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
    rogues = [Character.new('foo'), Character.new('foo')]
    gallery = RoguesGallery.new('Another rogues gallery')
    assert_raises(CharacterStateException) do
      gallery.add(rogues)
    end
  end
end
