require_relative '../../test_helper'
require 'psych'

class TestArmorClass < Minitest::Test
  include Evercraft
  def test__new
    assert_instance_of(Name, Name.new('good'))
    assert_instance_of(Name, Name.new('good-name'))
    assert_instance_of(Name, Name.new('good_name'))
    assert_instance_of(Name, Name.new('good_name23'))
  end

  def test_name__empty__invalid
    assert_raises(CharacterStateException) { Name.new('') }
  end

  def test_name__bad_chars__invalid
    assert_raises(CharacterStateException) do
      Name.new('Lorthar!$$')
    end
  end

  def test_name__too_many_chars_invalid
    assert_raises(CharacterStateException) do
      Name.new((0...66).map { ('a'..'z').to_a[rand(26)] }.join)
    end
  end

  def test_to_s
    good = Name.new('good')
    assert_equal('good', good.to_s)
  end
end
