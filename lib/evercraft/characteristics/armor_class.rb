module Evercraft
  class ArmorClass
    include Yamlable

    attr_reader :name, :score

    def initialize(name = 'default', score = AttributeScore.new(10))
      @name = Name.new(name).to_s
      @score = AttributeScore.new(score)
    end

    def to_i
      @score
    end

    def to_int
      @score
    end

    def to_s
      "ArmorClass: #{name} score: #{score.to_i}"
    end
  end
end
