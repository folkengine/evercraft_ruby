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
    character = Character.new(alignment: 'good')
    assert_equal character.alignment, Alignment.new(:GOOD)
  end

  def test_hit_points
    character = Character.new
    assert_equal character.hit_points.to_i, HitPoints::DEFAULT
  end

  def test_hit_points_high_constitution
    siegfried = Character.new(character_name: 'Siegfried', attributes: Attributes.new(constitution: 20))
    assert_equal siegfried.hit_points, siegfried.hit_points_base.to_i + siegfried.attributes.constitution.modifier
  end

  def test_hit_points_low_constitution
    mouse = Character.new(character_name: 'Mouse', attributes: Attributes.new(constitution: 1))
    assert_equal mouse.hit_points, 1
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

  def test_armor_modified
    achilles = Character.new(character_name: 'Achilles', attributes: Attributes.new(dexterity: 20))
    assert_equal achilles.armor_class_modified, achilles.armor_class.to_i + achilles.attributes.dexterity.modifier
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

  def test_level
    assert_equal Character.new(experience: 50).level, 1
    assert_equal Character.new(experience: 1000).level, 2
    assert_equal Character.new(experience: 1030).level, 2
    assert_equal Character.new(experience: 2030).level, 3
  end

  def test_level_effect_on_hitpoints
    assert_equal 1, Character.new(experience: 3, attributes: Attributes.new(constitution: 1)).hit_points
    assert_equal 7, Character.new(experience: 6003, attributes: Attributes.new(constitution: 1)).hit_points
    assert_equal 5, Character.new(experience: 3, attributes: Attributes.new(constitution: 10)).hit_points
    assert_equal 10, Character.new(experience: 1043, attributes: Attributes.new(constitution: 10)).hit_points
    assert_equal 18, Character.new(experience: 1043, attributes: Attributes.new(constitution: 19)).hit_points
    assert_equal 20, Character.new(experience: 1043, attributes: Attributes.new(constitution: 20)).hit_points
  end

  def test_level_effect_on_hitpoints_hercules
    attributes = Attributes.new(strength: 40, dexterity: 15, constitution: 40)
    hercules = Character.new(experience: 10_000, attributes: attributes)
    assert_equal hercules.hit_points_per_level, 15
    assert_equal hercules.level, 11
    assert_equal 11 * 15, hercules.hit_points
  end
end
