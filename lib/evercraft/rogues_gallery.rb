require 'pathname'
require 'harshed'

module Evercraft
  class RoguesGallery
    include Yamlable

    attr_reader :title, :rogues

    def initialize(title = RandomNameGenerator.flip_mode.compose, storage_base: RoguesGallery.default_storage_base)
      @title = title.to_s
      @rogues = Harshed::Harsh.new(:character_name,
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

    def to_disk
      @rogues.to_disk
    end

    def from_disk
      @rogues.from_disk
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

    def reset
      @rogues.to_a.each(&:reset)
    end

    def promote
      @rogues.to_a.each(&:level_up)
    end

    def to_s
      s = @title.to_s
      to_a.each do |rogue|
        s += "\n* #{rogue}"
      end
      s
    end

    def self.test_factory(how_many_rogues = 0)
      rogues_gallery = RoguesGallery.new(RandomNameGenerator.flip_mode.compose + 's')
      how_many_rogues.times { rogues_gallery.add(Evercraft::Character.test_factory) }
      rogues_gallery
    end

    def self.default_storage_base
      File.join(File.dirname(__FILE__), '..', '..', 'data', 'galleries')
    end

    def self.galleries
      pathnames = Pathname.new(default_storage_base).children
      pathnames.map do |pathname|
        RoguesGallery.new(pathname.each_filename.to_a.last).from_disk
      end
    end

    #
    def self.monsters
      RoguesGallery.new(:monsters, storage_base: File.join(File.dirname(__FILE__), '..', '..', 'data')).from_disk
    end
  end
end
