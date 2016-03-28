require_relative 'stuff/yamlable'

# Evercraft MMORPG API
module Evercraft
  class Character
    include Yamlable

    attr_reader :alignment, :character_name, :armor_class

    def initialize(character_name: Evercraft::Name.test_factory,
                   alignment: Evercraft::Alignment::NEUTRAL)
      @character_name = Evercraft::Name.new(character_name).to_s
      @alignment = alignment
      @armor_class = ArmorClass.new
    end

    def self.test_factory
      Character.new(alignment: Evercraft::Alignment.values.sample)
    end
  end
end
