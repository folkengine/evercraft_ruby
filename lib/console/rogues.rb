require_relative '../evercraft'

Pry::Commands.create_command 'rogues' do
  description 'Manages Rogues Galleries for EverCraft'

  def options(opt)
    opt.on :n, :new, 'Creates a new Rogues Gallery'
    opt.on :o, :open, 'Opens up an existing Roques Gallery'
  end

  def process
    if opts.new?
      @rogues_gallery = Evercraft::RoguesGallery.test_factory
    elsif opts.open?
      output.puts 'boop!'
    end
    output.puts @rogues_gallery.to_yaml
  end
end
