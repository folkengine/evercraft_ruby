require_relative '../evercraft'

# rubocop:disable Style/GlobalVars
$current_rogues_gallery = nil
# :reek:NilCheck
def prompt(gallery_name = nil)
  gallery_name = gallery_name.nil? ? '' : " #{gallery_name}"
  Pry.config.prompt_name = "EverCraft v.#{Evercraft::VERSION}#{gallery_name}"

  # rubocop:disable Lint/UnusedBlockArgument
  Pry.config.prompt = proc { |target_self, nest_level, pry| "#{pry.config.prompt_name}> " }
end

Pry::Commands.create_command 'rogues' do
  description 'Manages Rogues Galleries for EverCraft'

  def options(opt)
    opt.on :e, :existing, 'Open an existing Rogues Gallery'
    opt.on :i, :info, 'Displays information about current Rogues Gallery'
    opt.on :l, :list, 'Lists the existing Galleries'
    opt.on :n, :new, 'Creates a new Rogues Gallery'
    opt.on :o, :open, 'Opens up an existing Rogues Gallery'
    opt.on :s, :save, 'Saves the current Rogues Gallery to disk.'
    opt.on :y, :yaml, 'Displays information as YAML'
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/PerceivedComplexity
  # :reek:NilCheck
  # :reek:TooManyStatements
  def process
    if opts.new?
      $current_rogues_gallery = Evercraft::RoguesGallery.test_factory(2)
      prompt($current_rogues_gallery.title)
      output.puts $current_rogues_gallery.to_s
    elsif opts.open?
      $current_rogues_gallery.from_disk
    elsif opts.save?
      $current_rogues_gallery.promote
      $current_rogues_gallery.reset
      $current_rogues_gallery.to_disk
    end

    arg1 = get_arg(args)
    unless arg1.nil?
      $current_rogues_gallery = Evercraft::RoguesGallery.new(arg1)
      $current_rogues_gallery.from_disk
      output.puts $current_rogues_gallery.to_s
    end

    if opts.info?
      output.puts $current_rogues_gallery.to_s
      output.puts
      output.puts $current_rogues_gallery.to_yaml if opts.yaml?
    end
  end

  # :reek:NilCheck
  def get_arg(args)
    args[0].nil? ? nil : args[0].to_s
  end
end
