# Evercraft MMORPG API
module Evercraft
  class Character
    attr_reader :character_name

    def initialize(character_name = Evercraft::Name.test_factory)
      @character_name = Evercraft::Name.new(character_name).to_s
    end

    def to_yaml
      Psych.dump(self)
    end
  end
end
