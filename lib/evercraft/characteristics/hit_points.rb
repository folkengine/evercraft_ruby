module Evercraft
  class HitPoints
    include Yamlable

    attr_reader :score

    def initialize(score = 5)
      @score = score.to_int
    end

    def alive?
      score < 0
    end

    def to_i
      @score
    end

    def to_int
      @score
    end

    def to_s
      "HitPoints: #{score.to_int}"
    end
  end
end
