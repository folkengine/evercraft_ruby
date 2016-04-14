module Evercraft
  class Attributes

    attr_reader :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma

    # rubocop:disable Metrics/MethodLength
    def initialize(
        strength: AttributeScore.new(10),
        dexterity: AttributeScore.new(10),
        constitution: AttributeScore.new(10),
        wisdom: AttributeScore.new(10),
        intelligence: AttributeScore.new(10),
        charisma: AttributeScore.new(10))

      @strength = AttributeScore.new(strength)
      @dexterity = AttributeScore.new(dexterity)
      @constitution = AttributeScore.new(constitution)
      @wisdom = AttributeScore.new(wisdom)
      @intelligence = AttributeScore.new(intelligence)
      @charisma = AttributeScore.new(charisma)
    end
  end
end
