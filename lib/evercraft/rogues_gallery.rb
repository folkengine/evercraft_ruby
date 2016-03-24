module Evercraft
  class RoguesGallery
    attr_reader :description

    def initialize(description)
      @description = description
      @rogues = {}
    end

    def add(new_rogues)
      Array(new_rogues).each { |rogue| add_individual(rogue) }
      self
    end

    private

    def add_individual(rogue)
      character_name = rogue.character_name
      raise CharacterStateException.new('Duplicate Character name error') if @rogues.key?(character_name)
      @rogues[character_name] = rogue
    end
  end
end
