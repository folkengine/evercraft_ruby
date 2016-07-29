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
    attr_reader :name

    def initialize(name)
      @name = name.to_s

      n = NameValidator.new(name: name.to_s)
      raise CharacterStateException.new("Invalid Name: #{name}") unless n.validate.success?
    end

    def to_s
      @name
    end

    def self.test_factory
      Name.new(RandomNameGenerator.flip_mode.compose)
    end

    class NameValidator
      include Hanami::Validations
      MAX_NAME_LENGTH = 64

      validations do
        required(:name) { str? & size?(1..MAX_NAME_LENGTH) & filled? & format?(/\A[\-_a-zA-Z1234567890]+\z/) }
      end
    end
  end
end
