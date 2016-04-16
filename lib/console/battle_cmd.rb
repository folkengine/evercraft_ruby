require_relative '../evercraft'

Pry::Commands.create_command 'battle' do
  description 'Battle related commands'

  def options(opt)
    opt.on :r, :replay, 'Instant Replay of the current Battle'
    opt.on :n, :new, 'Create a random Rogues Gallery to Battle'
    opt.on :s, :save, 'Save the Battle'
    opt.on :y, :yaml, 'Dump out all Objects as YAML'
  end

  def process
    if opts.replay?
      replay
    else
      rogues = opts.new? ? Evercraft::RoguesGallery.test_factory(4) : $current_rogues_gallery

      if rogues.to_a.empty?
        output.puts 'No Rogues loaded'
        return
      end

      $current_battle = Evercraft::Battle.new(combatants: rogues)
      # set_prompt($current_battle.title)
      output.puts $current_battle.to_yaml if opts.yaml?
      turn while $current_battle.alive.length > 1
      output.puts "#{$current_battle.alive.first.character_name} is the victor!"
    end
  end

  def turn
    combatants = $current_battle.alive.shuffle

    # combatants.each do |c|
    #   output.puts "* #{c.character_name}"
    # end
    #
    combatants.each do |attacker|
      if attacker.alive?
        opponent = $current_battle.random_opponent(attacker)
        attack = Evercraft::Attack.new(attacker, opponent)

        output.puts attack.to_s
        output.puts attack.to_yaml if opts.yaml?

        result = $current_battle.attack(attack)
        output.puts "#{result.character_name} has been killed." unless result.nil?
      end

      $current_battle.alive.each do |c|
        puts ">>> #{c}"
      end
      puts
    end
  end

  def replay
    output.puts "No Battle to replay." if $current_battle.nil?
    output.puts "Replaying #{$current_battle.title}"

    instant_replay = Evercraft::Replay.new($current_battle)

    attack = instant_replay.step_forward
    while !attack.nil?

      output.puts "Attack #{instant_replay.pointer}: "

      s = opts.yaml? ? attack.to_yaml : attack.to_s
      output.puts s

      output.puts attack.attacker
      output.puts attack.target

      gets.chomp

      attack = instant_replay.step_forward
    end
  end
end
