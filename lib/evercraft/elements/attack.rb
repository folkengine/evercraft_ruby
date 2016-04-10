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
      @rolled.to_i >= @target.armor_class.to_i
    end

    def critical?
      @rolled.to_i == 20
    end

    def fumble?
      @rolled.to_i == 1
    end

    private

    def process
      @damage = 1 if hits?
      @damage = 2 if critical?
    end
  end
end
