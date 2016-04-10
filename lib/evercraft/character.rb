require_relative 'stuff/yamlable'

# Evercraft MMORPG API
module Evercraft
  class Character
    include Yamlable

    attr_reader :alignment, :character_name, :armor_class, :hit_points, :damage

    def initialize(character_name: Evercraft::Name.test_factory,
                   alignment: Evercraft::Alignment::NEUTRAL,
                   armor_class: ArmorClass.new,
                   hit_points: HitPoints.new,
                   damage: 0)
      @character_name = Evercraft::Name.new(character_name).to_s
      @alignment = alignment
      @armor_class = armor_class
      @hit_points = HitPoints.new(hit_points)
      @damage = damage
    end

    def attack(attackie)
      Attack.new(self, attackie)
    end

    def take_damage(damage)
      @damage += damage
      alive?
    end

    def current_hit_points
      @hit_points.to_i - @damage
    end

    def alive?
      (@hit_points.to_i - @damage) > 0
    end

    def dead?
      !alive?
    end

    def ==(other)
      character_name == other.character_name
    end

    def eql?(other)
      self == other
    end

    def to_s
      @character_name
    end

    def self.test_factory
      Character.new(alignment: Evercraft::Alignment.values.sample)
    end
  end
end
