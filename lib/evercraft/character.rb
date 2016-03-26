require_relative 'stuff/yamlable'

# Evercraft MMORPG API
module Evercraft
  class Character
    include Yamlable

    attr_reader :character_name

    def initialize(character_name = Evercraft::Name.test_factory)
      @character_name = Evercraft::Name.new(character_name).to_s
    end

    def alignment(alignment = '')
      @alignment = alignment unless alignment.empty?
      @alignment
    end
  end
end
