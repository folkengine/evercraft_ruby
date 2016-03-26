module Evercraft
  class RoguesGallery
    include Yamlable

    attr_reader :title

    def initialize(title)
      @title = title
      @rogues = Hashed.new(:character_name)
    end

    def store(new_rogues)
      Array(new_rogues).each do |rogue|
        raise CharacterStateException.new('Duplicate Character name error') if @rogues.key?(rogue.character_name)
        @rogues.store(rogue)
      end
      self
    end

    def self.test_factory
      RoguesGallery.new("#{RandomNameGenerator::GOBLIN}s")
    end
  end
end
