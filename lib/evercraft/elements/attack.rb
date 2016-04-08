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
      if critical?
        return 2
      elsif hits?
        return 1
      else
        0
      end
    end
  end
end
