# http://easydamus.com/alignmentreal.html
module Evercraft
  class Alignment

    def initialize(value = 'neutral')
      case value.to_s.strip.downcase
        when 'good'
          @alignment = 'good'
        when 'evil'
          @alignment = 'evil'
        else
          @alignment = 'neutral'
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
