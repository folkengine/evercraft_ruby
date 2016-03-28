module Evercraft
  class AttributeScore
    attr_reader :value

    def initialize(value)
      @value = value.to_int
    end

    def to_i
      @value
    end

    def to_int
      @value
    end
  end
end
