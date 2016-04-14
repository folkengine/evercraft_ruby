module Evercraft
  class Replay

    attr_reader :battle, :pointer

    def initialize(battle)
      @battle = battle
      init_replay(@battle)
    end

    private

    def step_forward
      attack = @attacks[@pointer]
      @replay.attack(attack)
      @pointer += 1
    end

    def init_replay(battle)
      @replay = Evercraft::Battle.new(@battle.combatants)
      @attacks = battle.attacks
      @pointer = 0
    end
  end
end
