require 'colorize'
require_relative '../evercraft'

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Style/GlobalVars
$current_character = nil

Pry::Commands.create_command 'character' do
  description 'Character related commands'

  def options(opt)
    opt.on :a, :add, 'Adds current Character to current Rogues Gallery'
    opt.on :c, :current, 'Full current Character information'
    opt.on :n, :new, 'Creates a new Character'
    opt.on :r, :random, 'Creates a random new Character'
  end

  # :reek:NilCheck
  def process
    if opts.add?
      $current_rogues_gallery.add($current_character) unless $current_character.nil?
    elsif opts.new?
      $current_character = input_character
      output.puts $current_character
    elsif opts.random?
      $current_character = Evercraft::Character.test_factory
      output.puts $current_character.to_yaml
    elsif opts.current?
      output.puts $current_character.nil? ? 'No current Character' : $current_character.to_yaml
    end
  rescue CharacterStateException
    output.puts 'ERROR: Invalid Character Name'.colorize(:red).bold
  end

  # :reek:DuplicateMethodCall
  # :reek:TooManyStatements
  def input_character
    output.print 'name: '
    character_name = Evercraft::Name.new(gets.chomp)

    output.print 'alignment (GOOD|NEUTRAL|EVIL): '
    alignment = Evercraft::Alignment.new(gets.chomp)

    output.print 'strength [10]: '
    strength = Evercraft::AttributeScore.new(gets.chomp.to_i)

    output.print 'dexterity [10]: '
    dexterity = Evercraft::AttributeScore.new(gets.chomp.to_i)

    output.print 'constitution [10]: '
    constitution = Evercraft::AttributeScore.new(gets.chomp.to_i)

    output.print 'wisdom [10]: '
    wisdom = Evercraft::AttributeScore.new(gets.chomp.to_i)

    output.print 'intelligence [10]: '
    intelligence = Evercraft::AttributeScore.new(gets.chomp.to_i)

    output.print 'charisma [10]: '
    charisma = Evercraft::AttributeScore.new(gets.chomp.to_i)

    attributes = Evercraft::Attributes.new(
      strength: strength,
      dexterity: dexterity,
      constitution: constitution,
      wisdom: wisdom,
      intelligence: intelligence,
      charisma: charisma
    )

    Evercraft::Character.new(character_name: character_name, alignment: alignment, attributes: attributes)
  end
end

Pry.commands.alias_command 'ch', 'character'
