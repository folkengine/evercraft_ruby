require 'ruby-enum'

# http://easydamus.com/alignmentreal.html
module Evercraft
  class Alignment
    include Ruby::Enum

    define :GOOD, 'good'
    define :NEUTRAL, 'neutral'
    define :EVIL, 'evil'
  end
end
