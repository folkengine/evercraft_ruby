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

    def lock
      @attacker = attacker.clone.freeze
      @target = target.clone.freeze
    end

    def hits?
      return true if @rolled.to_i == 20
      roll_modified >= target.armor_class_modified
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
      strength_mod = attacker.attributes.strength.modifier
      return 1 if strength_mod < 0
      1 + strength_mod
    end

    def critical_damage
      crit = 2 + (attacker.attributes.strength.modifier * 2)
      return 1 if crit < 1
      crit
    end

    def to_s
      attacker_name = attacker.character_name
      target_name = target.character_name
      return "#{attacker_name} critically hits #{target_name} for #{damage} hit points." if critical?
      return "#{attacker_name} hits #{target_name} for #{damage} hit points." if hits?
      return "#{attacker_name} fumbles attacking #{target_name}." if fumble?
      "#{attacker_name} misses #{target_name}"
    end

    private

    def process
      @damage = standard_damage if hits?
      @damage = critical_damage if critical?
    end
  end
end
