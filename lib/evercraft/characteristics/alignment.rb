require 'ruby-enum'

# http://easydamus.com/alignmentreal.html
module Evercraft
  class Alignment
    include Ruby::Enum

    define :GOOD, 'good'
    define :NEUTRAL, 'neutral'
    define :EVIL, 'evil'

    def self.parse(alignment)
      return Alignment.value(:GOOD) if alignment.strip.downcase.eql?('good')
      return Alignment.value(:EVIL) if alignment.strip.downcase.eql?('evil')
      :NEUTRAL
    end
  end
end
