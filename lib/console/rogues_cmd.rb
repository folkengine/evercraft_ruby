require_relative '../evercraft'

$current_rogues_gallery = nil

def set_prompt(gallery_name = nil)
  gallery_name = gallery_name.nil? ? '' : " #{gallery_name}"
  Pry.config.prompt_name = "EverCraft v.#{Evercraft::VERSION}#{gallery_name}"

  # rubocop:disable Lint/UnusedBlockArgument
  Pry.config.prompt = Proc.new { |target_self, nest_level, pry| "#{pry.config.prompt_name}> " }
end

Pry::Commands.create_command 'rogues' do
  description 'Manages Rogues Galleries for EverCraft'

  def options(opt)
    opt.on :i, :info, 'Displays information about current Rogues Gallery'
    opt.on :l, :list, 'Lists the existing Galleries'
    opt.on :n, :new, 'Creates a new Rogues Gallery'
    opt.on :o, :open, 'Opens up an existing Rogues Gallery'
    opt.on :s, :save, 'Saves the current Rogues Gallery to disk.'
  end

  def process
    if opts.new?
      $current_rogues_gallery = Evercraft::RoguesGallery.test_factory
      set_prompt($current_rogues_gallery.title)
    elsif opts.open?
      $current_rogues_gallery.retrieve_from_disk
    elsif opts.save?
      $current_rogues_gallery.store_to_disk
    end
    output.puts $current_rogues_gallery.to_yaml
  end
end
