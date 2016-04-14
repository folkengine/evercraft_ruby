require_relative 'stuff/yamlable'

# Evercraft MMORPG API
module Evercraft
  class Character
    include Yamlable

    attr_reader :character_name, :alignment, :attributes, :armor_class, :hit_points, :damage

    def initialize(character_name: Evercraft::Name.test_factory,
                   alignment: Evercraft::Alignment::NEUTRAL,
                   attributes: Attributes.new,
                   armor_class: ArmorClass.new,
                   hit_points: HitPoints.new,
                   damage: 0,
                   experience: 0)
      @character_name = Evercraft::Name.new(character_name).to_s.freeze
      @alignment = alignment.freeze
      @attributes = attributes
      @armor_class = armor_class
      @hit_points = HitPoints.new(hit_points)
      @damage = damage
      @experience = experience
    end

    def gain_experience(ex)
      @experience += ex
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
      @character_name == other.character_name
    end

    def eql?(other)
      self == other
    end

    def to_s
      return "#{@character_name} is dead." if dead?
      "#{@character_name} HP: #{current_hit_points.to_i} EX: #{@experience}"
    end

    def self.test_factory
      Character.new(alignment: Evercraft::Alignment.values.sample)
    end
  end
end
