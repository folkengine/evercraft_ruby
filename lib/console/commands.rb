require 'pry'

require_relative 'battle_cmd'
require_relative 'character_cmd'
require_relative 'rogues_cmd'
require_relative 'scratch_cmd'

$current_rogues_gallery = Evercraft::RoguesGallery.new('default')
$current_battle = nil

set_prompt
