require_relative '../test_helper'
require 'psych'

class TestBattle < Minitest::Test
  include Evercraft

  def setup
    @combatant1 = Character.new
    @combatant2 = Character.new
    @battle = Battle.new
  end

  def test_oneway
    attacker = Character.new
    attackie = Character.new
    battle = Battle.new
    roll18 = Roll.new(18)

    4.times do
      battle.attack(Attack.new(attacker, attackie, roll18))
      assert battle.alive?(attackie)
    end

    battle.attack(Attack.new(attacker, attackie, roll18))
    assert battle.dead?(attackie)
  end
end
