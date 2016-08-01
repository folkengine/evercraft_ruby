module Evercraft
  class AttributeScore
    include Comparable

    attr_reader :value

    DEFAULT_VALUE = 10
    MAX_MODIFIER = 10

    MODIFIERS = [-5, -4, -4, -3, -3, -2, -2, -1, -1, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9].freeze

    def initialize(value = DEFAULT_VALUE)
      intvalue = value.to_int
      @value = intvalue < 1 ? DEFAULT_VALUE : intvalue
    end

    def to_i
      @value
    end

    def to_int
      @value
    end

    def modifier
      return MAX_MODIFIER if @value > 29
      MODIFIERS[@value - 1]
    end

    def self.test_value
      4 + Random.rand(16)
    end

    # :reek:FeatureEnvy
    def <=>(other)
      us = value
      them = other.to_i
      result = 0
      result = -1 if us < them
      result = 1 if us > them
      result
    end
  end
end
