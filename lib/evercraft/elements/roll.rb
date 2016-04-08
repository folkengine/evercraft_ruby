module Evercraft
  class Roll
    attr_reader :result, :die

    D20 = 20

    def initialize(result, die = D20)
      @result = result
      @die = die
    end

    def self.d20
      Roll.new(Roll.random(D20), D20)
    end

    def to_i
      @result
    end

    def to_int
      @result
    end

    private

    def self.random(integer)
      1 + rand(integer)
    end
  end
end
