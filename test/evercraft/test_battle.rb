require_relative '../test_helper'
require 'psych'

class TestBattle < Minitest::Test
  include Evercraft

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

  def test_number_alive
    battle = Battle.new
    battle.attack(Attack.new(Character.new, Character.new, Roll.new(18)))
    assert battle.number_alive, 2

    battle.attack(Attack.new(Character.new, Character.new, Roll.new(18)))
    assert battle.number_alive, 4
  end

  def test_alive
    battle = Battle.new
    attacker = Character.new
    attackie = Character.new
    battle.attack(Attack.new(attacker, attackie, Roll.new(18)))
    assert_equal battle.alive.length, 2
  end

  def test_include
    battle = Battle.new
    attacker = Character.new
    attackie = Character.new
    battle.attack(Attack.new(attacker, attackie, Roll.new(18)))
    assert battle.include?(attacker)
    assert battle.combatants.include?(attackie)

    battle.attack(Attack.new(attacker, attackie, Roll.new(18)))
    battle.attack(Attack.new(attacker, attackie, Roll.new(18)))
  end

  def test_min
    battle = Battle.new
    tom = Character.new(character_name: 'Tom', attributes: Attributes.new(strength: 1, constitution: 1))
    jerry = Character.new(character_name: 'Jerry', attributes: Attributes.new(strength: 1, constitution: 1))
    result = battle.attack(Attack.new(tom, jerry, Roll.new(20)))
    assert !result.nil?
  end

  # rubocop:disable Metrics/AbcSize
  def test_drive
    rogues = Evercraft::RoguesGallery.new(RandomNameGenerator.flip_mode.compose)
    4.times { rogues.add(Evercraft::Character.test_factory) }
    my_battle = Evercraft::Battle.new(combatants: rogues)

    puts my_battle.title

    while my_battle.alive.length > 1
      attacker = my_battle.alive.sample
      opponent = my_battle.random_opponent(attacker)

      attack = Evercraft::Attack.new(attacker, opponent)
      puts attack.to_s
      result = my_battle.attack(attack)
      puts "#{result.first.character_name} has been killed." unless result.empty?

      my_battle.alive.each do |c|
        puts ">>> #{c}"
      end
      puts
    end

    puts "#{my_battle.alive.first.character_name} is the victor!"
  end
end
