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

  def test_alignment
    character = Character.new(alignment: Alignment::GOOD)
    assert_equal character.alignment, Alignment::GOOD
  end

  def test_hit_points
    character = Character.new
    assert_equal character.hit_points.to_i, HitPoints::DEFAULT
  end

  def test_current_hit_points
    character = Character.new
    assert_equal character.current_hit_points, HitPoints::DEFAULT

    character.take_damage(1)
    assert_equal character.current_hit_points, HitPoints::DEFAULT - 1

    character.take_damage(6)
    assert_equal character.current_hit_points, HitPoints::DEFAULT - 7
  end

  def test_alive
    character = Character.new
    assert character.alive?

    character.take_damage(1)
    assert character.alive?

    character.take_damage(0)
    assert character.alive?
  end

  def test_dead
    character = Character.new
    assert !character.dead?

    character.take_damage(1)
    assert !character.dead?

    character.take_damage(5)
    assert character.dead?
  end

  def test_take_damage
    character = Character.new
    assert character.take_damage(1)
    assert_equal 1, character.damage

    assert !character.take_damage(5)
    assert_equal 6, character.damage
  end
end
