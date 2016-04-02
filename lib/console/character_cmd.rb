require_relative '../evercraft'

Pry::Commands.create_command 'character' do
  description 'Character related commands'

  def process
    output.puts Evercraft::Character.new.to_yaml
  end
end

Pry.commands.alias_command 'ch', 'character'
