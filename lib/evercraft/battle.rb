require 'set'

module Evercraft
  class Battle
    include Yamlable

    attr_reader :attacks, :combatants

    def initialize(combatants = RoguesGallery.new("Battle of #{RandomNameGenerator.flip_mode.compose}"))
      @combatants = combatants
      @attacks = []
    end

    def attack(attack)
      process_combatants(attack)
      process_attack(attack)
    end

    def alive
      @combatants.to_a.find_all(&:alive?)
    end

    def alive?(target)
      @combatants.rogue(target.character_name).alive?
    end

    def dead?(target)
      !alive?(target)
    end

    def include?(rogue)
      @combatants.include?(rogue)
    end

    def number_alive
      return -1 unless started?
      alive.count
    end

    def started?
      @attacks.empty?
    end

    def random_opponent(character)
      alive.find_all { |i| i.character_name != character.character_name }.sample
    end

    def title
      @combatants.title
    end

    private

    def process_combatants(attack)
      @combatants.add(attack.attacker) unless @combatants.include?(attack.attacker)
      @combatants.add(attack.target) unless @combatants.include?(attack.target)
    end

    def process_attack(attack)
      @attacks << attack
      @combatants.rogue(attack.attacker.character_name).gain_experience(10) if attack.hits?
      @combatants.rogue(attack.target.character_name).take_damage(attack.damage)
      alive?(attack.target) ? nil : @combatants.rogue(attack.target)
    end
  end
end
