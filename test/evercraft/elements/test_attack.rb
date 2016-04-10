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
end
