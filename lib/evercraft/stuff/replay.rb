module Evercraft
  class Replay

    attr_reader :battle, :replay, :pointer

    def initialize(battle)
      @battle = battle
      init_replay(@battle)
    end

    def step_forward
      return nil if @pointer >= @attacks.size
      current_attack = @attacks[@pointer]
      @replay.attack(current_attack)
      @pointer += 1
      current_attack
    end

    def step_backward
      return nil if @pointer == 0
      @pointer -= 1
      current_attack = @attacks[@pointer]
      @replay.attack(current_attack)
      current_attack
    end

    def reset
      @pointer = 0
      self
    end

    private

    def init_replay(battle)
      battle.reset
      @replay = Evercraft::Battle.new(combatants: battle.combatants)
      @attacks = battle.attacks
      @pointer = 0
    end
  end
end
