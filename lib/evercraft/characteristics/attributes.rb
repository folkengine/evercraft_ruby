module Evercraft
  class Attributes
    attr_reader :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma

    # rubocop:disable Metrics/MethodLength
    def initialize(
        strength: AttributeScore.new,
        dexterity: AttributeScore.new,
        constitution: AttributeScore.new,
        wisdom: AttributeScore.new,
        intelligence: AttributeScore.new,
        charisma: AttributeScore.new)

      @strength = AttributeScore.new(strength)
      @dexterity = AttributeScore.new(dexterity)
      @constitution = AttributeScore.new(constitution)
      @wisdom = AttributeScore.new(wisdom)
      @intelligence = AttributeScore.new(intelligence)
      @charisma = AttributeScore.new(charisma)
    end

    def self.factory(sum: 60, top_limit: 20, bottom_limit: 1)

    end
  end
end
