require_relative '../../test_helper'
require 'psych'

class TestAttack < Minitest::Test
  include Evercraft

  def setup
    @attacker = Character.new(character_name: 'attacker')
    @attackie = Character.new(character_name: 'attackie')
  end

  def test_new
    attack = Attack.new(@attacker, @attackie)
    assert attack.attacker == @attacker
    assert attack.target == @attackie
  end

  def test_hit
    attack = Attack.new(@attacker, @attackie, Roll.new(18))
    assert attack.hits?
    assert_equal 1, attack.damage

    attack = Attack.new(@attacker, @attackie, Roll.new(10))
    assert attack.hits?
    assert_equal 1, attack.damage
  end

  def test_critical
    roll20 = Roll.new(20)
    assert_equal roll20.to_i, 20
    attack = Attack.new(@attacker, @attackie, roll20)
    assert attack.hits?
    assert attack.critical?
    assert_equal 2, attack.damage
  end

  def test_miss
    attack = Attack.new(@attacker, @attackie, Roll.new(1))
    assert !attack.hits?
    assert attack.fumble?
  end

  def test_strength_mod_roll_hits
    attack_roll = Roll.new(12)
    hercules = Character.new(character_name: 'Hercules', attributes: Attributes.new(strength: 18))
    attackie = Character.new(character_name: 'Attackie')
    attack = Attack.new(hercules, attackie, attack_roll)

    assert_equal attack.roll_modified, hercules.attributes.strength.modifier + attack_roll.to_i
    assert attack.hits?
  end

  def test_strength_mod_damage
    attack_roll = Roll.new(12)
    hercules = Character.new(character_name: 'Hercules', attributes: Attributes.new(strength: 18))
    attackie = Character.new(character_name: 'Attackie')
    attack = Attack.new(hercules, attackie, attack_roll)

    assert_equal 1 + hercules.attributes.strength.modifier, attack.standard_damage
    assert_equal 1 + hercules.attributes.strength.modifier, attack.damage
  end

  def test_strength_mod_critical_damage
    attack_roll = Roll.new(20)
    hercules = Character.new(character_name: 'Hercules', attributes: Attributes.new(strength: 18))
    attackie = Character.new(character_name: 'Attackie')
    attack = Attack.new(hercules, attackie, attack_roll)

    expected_damage = 2 + (hercules.attributes.strength.modifier * 2)
    assert_equal expected_damage, attack.critical_damage
    assert_equal expected_damage, attack.damage
  end

  def test_strength_mod_critical_weak
    attack_roll = Roll.new(20)
    abbot = Character.new(character_name: 'Abbot', attributes: Attributes.new(strength: 1))
    attackie = Character.new(character_name: 'Attackie')
    attack = Attack.new(abbot, attackie, attack_roll)

    expected_damage = 1
    assert_equal expected_damage, attack.critical_damage
    assert_equal expected_damage, attack.damage
  end

  def test_strength_mod_attack_roll_miss
    attack_roll = Roll.new(12)
    abbot = Character.new(character_name: 'Hercules', attributes: Attributes.new(strength: 1))
    attackie = Character.new(character_name: 'Attackie')
    attack = Attack.new(abbot, attackie, attack_roll)

    assert_equal attack.roll_modified, abbot.attributes.strength.modifier + attack_roll.to_i
    assert !attack.hits?
  end

  # rubocop:disable Metrics/AbcSize
  def test_dex_mod_armor_high_roll
    attack_roll = Roll.new(10)
    hercules = Character.new(character_name: 'Hercules', attributes: Attributes.new(strength: 18))
    achilles = Character.new(character_name: 'Achilles', attributes: Attributes.new(dexterity: 20))
    attack = Attack.new(hercules, achilles, attack_roll)

    assert_equal attack.roll_modified, hercules.attributes.strength.modifier + attack_roll.to_i
    assert_equal achilles.armor_class_modified, achilles.attributes.dexterity.modifier.to_i + achilles.armor_class.to_i
    assert !attack.hits?
  end

  def test_dex_mod_armor_high_critical
    attack_roll = Roll.new(20)
    abbot = Character.new(character_name: 'Hercules', attributes: Attributes.new(strength: 1))
    achilles = Character.new(character_name: 'Achilles', attributes: Attributes.new(dexterity: 20))
    attack = Attack.new(abbot, achilles, attack_roll)

    assert_equal attack.roll_modified, abbot.attributes.strength.modifier + attack_roll.to_i
    assert_equal achilles.armor_class_modified, achilles.attributes.dexterity.modifier.to_i + achilles.armor_class.to_i
    assert attack.hits?
    assert attack.critical?
  end

  def test_min
    tom = Character.new(character_name: 'Tom', attributes: Attributes.new(strength: 1, constitution: 1))
    jerry = Character.new(character_name: 'Jerry', attributes: Attributes.new(strength: 1, constitution: 1))
    attack = Attack.new(tom, jerry, Roll.new(20))
    assert_equal attack.damage, 1
  end
end
