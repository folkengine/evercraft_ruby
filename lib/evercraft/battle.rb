require 'set'

module Evercraft
  class Battle
    include Yamlable

    attr_reader :title, :attacks, :combatants

    def initialize(
        title: "Battle of #{RandomNameGenerator.flip_mode.compose}",
        combatants: RoguesGallery.new(RandomNameGenerator.flip_mode.compose))
      @title = title
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

    def reset
      @combatants.reset
    end

    def playout
      while(alive.length > 1)
        attacker = alive.sample
        opponent = random_opponent(attacker)
        attack = Evercraft::Attack.new(attacker, opponent)
        result = attack(attack)
      end
      self
    end

    def self.test_factory
      rogues = Evercraft::RoguesGallery.new(RandomNameGenerator.flip_mode.compose)
      2.times { rogues.add(Evercraft::Character.test_factory) }
      my_battle = Evercraft::Battle.new(combatants: rogues)
      return my_battle
    end

    def self.test_factory_playout
      test_factory.playout
    end

    private

    def process_combatants(attack)
      @combatants.add(attack.attacker) unless @combatants.include?(attack.attacker)
      @combatants.add(attack.target) unless @combatants.include?(attack.target)
    end

    # This method smells of :reek:FeatureEnvy but ignores them
    def process_attack(attack)
      @attacks << attack
      @combatants.rogue(attack.attacker.character_name).gain_experience(10) if attack.hits?
      @combatants.rogue(attack.target.character_name).take_damage(attack.damage)
      attack.lock
      alive?(attack.target) ? [] : [@combatants.rogue(attack.target.character_name)]
    end
  end
end
