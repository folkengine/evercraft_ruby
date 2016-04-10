require_relative '../evercraft'

Pry::Commands.create_command 'scratch' do
  description 'Pry Scratch Pad'

  def process
    @rogues_gallery = Evercraft::RoguesGallery.test_factory
    greenleaf = Evercraft::Character.new(character_name: 'Greenleaf')
    foobar = Evercraft::Character.new(character_name: 'Foobar')
    @rogues_gallery.add(greenleaf)
    @rogues_gallery.add(foobar)

    output.puts @rogues_gallery.to_yaml
    output.puts
    attack = Evercraft::Attack.new(greenleaf, foobar).roll
    output.puts "#{greenleaf.character_name} rolls #{attack.rolled.to_i} hits #{attack.hits?} #{greenleaf.character_name}"
  end
end
