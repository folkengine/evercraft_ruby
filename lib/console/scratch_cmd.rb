require_relative '../evercraft'

Pry::Commands.create_command 'scratch' do
  description 'Pry Scratch Pad'

  def process
    @rogues_gallery = Evercraft::RoguesGallery.test_factory
    greenleaf = Evercraft::Character.new(character_name: 'Greenleaf')
    foobar = Evercraft::Character.new(character_name: 'Foobar')
    @rogues_gallery.store(greenleaf)
    @rogues_gallery.store(foobar)

    output.puts @rogues_gallery.to_yaml
  end
end
