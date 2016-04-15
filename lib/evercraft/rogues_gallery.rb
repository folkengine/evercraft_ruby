require 'pathname'

module Evercraft
  class RoguesGallery
    include Yamlable

    attr_reader :title, :rogues

    def initialize(title = RandomNameGenerator.flip_mode.compose, storage_base: RoguesGallery.default_storage_base)
      @title = title.to_s
      @rogues = Harshed.new(:character_name,
                            storage_base: storage_base,
                            storage_folder: @title)
    end

    def add(new_rogues)
      Array(new_rogues).each do |rogue|
        raise CharacterStateException.new('Duplicate Character name error') if include?(rogue)
        @rogues.store(rogue)
      end
      self
    end

    def store_to_disk
      @rogues.store_to_disk
    end

    def retrieve_from_disk
      @rogues.retrieve_from_disk
      self
    end

    def rogue(rogue)
      @rogues.value(rogue.to_s)
    end

    def include?(rogue)
      @rogues.key?(rogue.character_name)
    end

    def sample
      @rogues.sample
    end

    def rm_r
      @rogues.rm_r
    end

    def to_a
      @rogues.to_a
    end

    def self.test_factory(how_many_rogues = 0)
      rogues_gallery = RoguesGallery.new(RandomNameGenerator.flip_mode.compose + 's')
      how_many_rogues.times { rogues_gallery.add(Evercraft::Character.test_factory)  }
      rogues_gallery
    end

    def self.default_storage_base
      File.join(Harshed.default_base_folder, 'galleries')
    end

    def self.galleries
      pathnames = Pathname.new(default_storage_base).children
      pathnames.map do |pathname|
        RoguesGallery.new(pathname.each_filename.to_a.last).retrieve_from_disk
      end
    end

    #
    def self.monsters
      RoguesGallery.new(:monsters, storage_base: Harshed.default_base_folder).retrieve_from_disk
    end
  end
end
