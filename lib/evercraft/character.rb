require_relative 'stuff/yamlable'

# Evercraft MMORPG API
module Evercraft
  class Character
    include Yamlable

    attr_reader :alignment, :character_name, :armor_class, :hit_points

    def initialize(character_name: Evercraft::Name.test_factory,
                   alignment: Evercraft::Alignment::NEUTRAL)
      @character_name = Evercraft::Name.new(character_name).to_s
      @alignment = alignment
      @armor_class = ArmorClass.new
      @hit_points = HitPoints.new
    end

    def ==(other)
      character_name == other.character_name
    end

    def eql?(other)
      self == other
    end

    def self.test_factory
      Character.new(alignment: Evercraft::Alignment.values.sample)
    end
  end
end
