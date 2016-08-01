# http://easydamus.com/alignmentreal.html
module Evercraft
  class Alignment
    def initialize(value = 'neutral')
      @alignment = case value.to_s.strip.downcase
                   when 'good'
                     'good'
                   when 'evil'
                     'evil'
                   else
                     'neutral'
                   end
      @alignment.freeze
    end

    def ==(other)
      @alignment == other.to_s.strip.downcase
    end

    def eql?(other)
      @alignment == other.to_s.strip.downcase
    end

    def to_s
      @alignment
    end

    def to_str
      @alignment
    end

    def self.test_factory
      Alignment.new([:good, :neutral, :evil].sample)
    end
  end
end
