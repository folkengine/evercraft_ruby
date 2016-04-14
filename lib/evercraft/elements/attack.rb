module Evercraft
  class Attack
    include Yamlable

    attr_reader :attacker, :target, :rolled, :damage

    def initialize(attacker, target, rolled = Roll.d20)
      @attacker = attacker
      @target = target
      @rolled = rolled
      @damage = 0
      process
    end

    def hits?
      roll_modified >= @target.armor_class.to_i
    end

    def critical?
      @rolled.to_i == 20
    end

    def fumble?
      @rolled.to_i == 1
    end

    def roll_modified
      @rolled.to_i + attacker.attributes.strength.modifier
    end

    def standard_damage
      return 1 if attacker.attributes.strength.modifier < 0
      1 + attacker.attributes.strength.modifier
    end

    def critical_damage
      return 2 if attacker.attributes.strength.modifier < 0
      2 + (attacker.attributes.strength.modifier * 2)
    end

    def to_s
      return "#{attacker.character_name} critically hits #{target.character_name} for #{damage} hit points." if critical?
      return "#{attacker.character_name} hits #{target.character_name} for #{damage} hit points." if hits?
      return "#{attacker.character_name} fumbles attacking #{target.character_name}." if fumble?
      "#{attacker.character_name} misses #{target.character_name}"
    end

    private

    def process
      @damage = standard_damage if hits?
      @damage = critical_damage if critical?
    end
  end
end
