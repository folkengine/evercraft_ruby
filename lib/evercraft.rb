require 'hanami/validations'

dirname = File.dirname(__FILE__)

require File.join(dirname, 'evercraft', 'character')
require File.join(dirname, 'evercraft', 'battle')
require File.join(dirname, 'evercraft', 'rogues_gallery')
require File.join(dirname, 'evercraft', 'version')
require File.join(dirname, 'evercraft', 'characteristics', 'alignment')
require File.join(dirname, 'evercraft', 'characteristics', 'armor_class')
require File.join(dirname, 'evercraft', 'characteristics', 'attributes')
require File.join(dirname, 'evercraft', 'characteristics', 'hit_points')
require File.join(dirname, 'evercraft', 'characteristics', 'name')
require File.join(dirname, 'evercraft', 'elements', 'attack')
require File.join(dirname, 'evercraft', 'elements', 'attribute_score')
require File.join(dirname, 'evercraft', 'elements', 'roll')
require File.join(dirname, 'evercraft', 'stuff', 'character_state_exception')
require File.join(dirname, 'evercraft', 'stuff', 'harshed')
require File.join(dirname, 'evercraft', 'stuff', 'yamlable')

# greenleaf = Evercraft::Character.new(character_name: 'Greenleaf')
# foobar = Evercraft::Character.new(character_name: 'Foobar')
#
# attack = Evercraft::Attack.new(greenleaf, foobar).roll
# puts "#{greenleaf.character_name} rolls #{attack.rolled.to_i} hits #{attack.hits?} #{greenleaf.character_name}"
