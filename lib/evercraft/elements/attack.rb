module Evercraft
  class Attack
    include Yamlable

    attr_reader :attacker, :target, :rolled

    def initialize(attacker, target, rolled = Roll.d20)
      @attacker = attacker
      @target = target
      @rolled = rolled
    end

    def hits?
      @rolled.to_i >= @target.armor_class.to_i
    end

    def critical?
      @rolled.to_i == 20
    end

    def fumble?
      @rolled.to_i == 1
    end

    def damage
      return 2 if critical?
      return 1 if hits?
      0
    end
  end
end
