module Evercraft
  class AttributeScore
    attr_reader :value

    MODIFIERS = [-5, -4, -4, -3, -3, -2, -2, -1, -1, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5].freeze

    def initialize(value)
      @value = value.to_int
    end

    def to_i
      @value
    end

    def to_int
      @value
    end

    def modifier
      MODIFIERS[@value - 1]
    end
  end
end
