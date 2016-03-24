require 'random_name_generator'

# Feature:
#   As a character I want to have a name so that I can be distinguished from other characters
# Requirement
#   Get and Set Name
#
# Characteristics:
# Basic:
# * Must have Length
# * Can't go on for ever
# * Only made up of letters, numbers, underscores and hyphens
# *
# Advanced: (tech debt)
# * Unique
# * Owned by a specific User
#
module Evercraft
  class Name
    include Hanami::Validations

    def initialize(name)
      @name = name.to_s
      raise CharacterStateException.new('Invalid Name') unless valid?
    end

    # http://www.rubydoc.info/gems/hanami-validations#Format
    attribute :name, type: String, size: 1..12, presence: true, format: /\A[\-_a-zA-Z1234567890]+\z/

    attr_reader :name

    def to_s
      @name
    end

    def self.test_factory
      Name.new(RandomNameGenerator.flip_mode)
    end
  end
end
