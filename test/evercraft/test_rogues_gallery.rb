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
      gallery.add(rogues)
    end
  end

  def test_store_to_disk
    gallery = RoguesGallery.test_factory
    char1 = Character.test_factory
    char2 = Character.test_factory
    gallery.add(char1)
    gallery.add(char2)
    gallery.store_to_disk
    assert_equal(gallery.to_a.length, Pathname.new(gallery.rogues.folder_path).children.length)
    gallery.rm_r
  end

  def test_retrieve_from_disk
    gallery = RoguesGallery.monsters
    assert_equal(2, gallery.to_a.length)
  end

  def test_galleries
    Evercraft::RoguesGallery.galleries.each do |gallery|
      # puts gallery.to_yaml
    end
  end
end
