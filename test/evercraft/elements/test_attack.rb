require_relative '../../test_helper'
require 'psych'

class TestAttack < Minitest::Test
  include Evercraft

  def setup
    @attacker = Character.new(character_name: 'attacker')
    @attackie = Character.new(character_name: 'attackie')
    @attack = Attack.new(@attacker, @attackie)
  end

  def test_new
    attack = Attack.new(@attacker, @attackie)
    assert attack.attacker == @attacker
    assert attack.target == @attackie
  end

  def test_hit
    attack = Attack.new(@attacker, @attackie, Roll.new(18))
    assert attack.hits?
    assert_equal attack.damage, 1

    attack = Attack.new(@attacker, @attackie, Roll.new(10))
    assert attack.hits?
    assert_equal attack.damage, 1
  end

  def test_miss
    attack = Attack.new(@attacker, @attackie, Roll.new(1))
    assert !attack.hits?
    assert attack.fumble?
  end
end
