require 'ruby-enum'

# http://easydamus.com/alignmentreal.html
module Evercraft
  class Alignment
    # Lawful good	Neutral good	Chaotic good
    # Lawful neutral	(True) neutral	Chaotic neutral
    # Lawful evil	Neutral evil	Chaotic evil

    define :GOOD, 'good'
    define :NEUTRAL, 'neutral'
    define :EVIL, 'evil'
  end
end
