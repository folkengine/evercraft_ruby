module Evercraft
  class AttributeScore
    attr_reader :value

    DEFAULT_VALUE = 10
    MAX_MODIFIER = 10

    MODIFIERS = [-5, -4, -4, -3, -3, -2, -2, -1, -1, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9].freeze

    def initialize(value = DEFAULT_VALUE)
      @value = value.to_int < 1 ? DEFAULT_VALUE : value.to_int
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
  end
end
