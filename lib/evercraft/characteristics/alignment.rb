require 'ruby-enum'

# http://easydamus.com/alignmentreal.html
module Evercraft
  class Alignment
    include Ruby::Enum

    define :GOOD, 'good'
    define :NEUTRAL, 'neutral'
    define :EVIL, 'evil'

    def self.parse(alignment)
      return :GOOD if alignment.strip.casecmp('good')
      return :EVIL if alignment.strip.casecmp('evil')
      :NEUTRAL
    end
  end
end
