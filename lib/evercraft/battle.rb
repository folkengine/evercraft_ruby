module Evercraft
  class Battle
    include Yamlable

    def initialize(combatant1, combatant2)
      @combatant1 = combatant1
      @combatant2 = combatant2
    end
  end
end
