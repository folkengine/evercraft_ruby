require 'set'

module Evercraft
  class Battle
    include Yamlable

    attr_reader :attacks, :name

    def initialize(name: RandomNameGenerator.new(RandomNameGenerator::GOBLIN).compose)
      @name = name
      @combatants = RoguesGallery.new("Battle of #{name}")
      @attacks = []
    end

    def attack(attack)
      process_combatants(attack)
      process_attack(attack)
    end

    def alive?(target)
      @combatants.rogue(target).alive?
    end

    def dead?(target)
      !alive?(target)
    end

    private

    def process_combatants(attack)
      @combatants.add(attack.attacker) unless @combatants.include?(attack.attacker)
      @combatants.add(attack.target) unless @combatants.include?(attack.target)
    end

    def process_attack(attack)
      @attacks << attack
      @combatants.rogue(attack.target.character_name).take_damage(attack.damage)
      alive?(attack.target) ? [] : @combatants.rogue(attack.target)
    end
  end
end
