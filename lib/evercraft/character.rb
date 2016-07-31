require 'yamlable'

# Evercraft MMORPG API
module Evercraft
  class Character
    include Yamlable

    attr_reader :damage, :current_experience
    attr_reader :character_name, :alignment, :attributes, :armor_class, :damage, :experience

    def initialize(character_name: Evercraft::Name.test_factory,
                   alignment: 'neutral',
                   attributes: Attributes.new,
                   armor_class: ArmorClass.new,
                   hit_points: HitPoints.new,
                   damage: 0,
                   experience: 0)
      @character_name = Evercraft::Name.new(character_name).to_s.freeze
      @alignment = Alignment.new(alignment)
      @attributes = attributes
      @armor_class = armor_class
      @hit_points_base = HitPoints.new(hit_points)
      @damage = damage
      @experience = experience
      @current_experience = 0
    end

    def gain_experience(ex)
      @current_experience += ex
    end

    def level_up
      @experience = @current_experience
    end

    def reset
      @current_experience = 0
      @damage = 0
    end

    def attack(attackie)
      Attack.new(self, attackie)
    end

    def take_damage(damage)
      @damage += damage
      alive?
    end

    def armor_class_modified
      @armor_class.to_i + @attributes.dexterity.modifier
    end

    def hit_points
      hit_points_per_level * level
    end

    def hit_points_per_level
      hp_plus_mod = @hit_points_base.to_i + @attributes.constitution.modifier
      return 1 if hp_plus_mod < 1
      hp_plus_mod
    end

    def current_hit_points
      hit_points - @damage
    end

    def hit_points_base
      @hit_points_base
    end

    def level
      (@experience / 1000).to_i + 1
    end

    def alive?
      current_hit_points > 0
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
      "#{@character_name} HP: #{current_hit_points.to_i} EX: #{@experience + @current_experience}"
    end

    def self.test_factory
      Character.new(alignment: Evercraft::Alignment.test_factory)
    end
  end
end
