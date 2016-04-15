require_relative '../evercraft'

Pry::Commands.create_command 'battle' do
  description 'Battle related commands'

  def process
    rogues = Evercraft::RoguesGallery.test_factory(4)

    @battle = Evercraft::Battle.new(rogues)
    set_prompt($current_rogues_gallery.title)

    output.puts @battle.to_yaml

    turn while @battle.alive.length > 1

    output.puts "#{@battle.alive.first.character_name} is the victor!"
  end

  def turn
    attacker = @battle.alive.sample
    opponent = @battle.random_opponent(attacker)

    attack = Evercraft::Attack.new(attacker, opponent)
    output.puts attack.to_s
    result = @battle.attack(attack)
    output.puts "#{result.character_name} killed." unless result.nil?

    @battle.alive.each do |c|
      puts ">>> #{c}"
    end
    puts
  end
end
