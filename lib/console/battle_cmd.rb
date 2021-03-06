require_relative '../evercraft'

# rubocop:disable Style/GlobalVars
Pry::Commands.create_command 'battle' do
  description 'Battle related commands'

  def options(opt)
    opt.on :r, :replay, 'Instant Replay of the current Battle'
    opt.on :R, :reset, 'Resets the Rogues values'
    opt.on :n, :new, 'Create a random Rogues Gallery to Battle'
    opt.on :s, :save, 'Save the Battle'
    opt.on :y, :yaml, 'Dump out all Objects as YAML'
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/PerceivedComplexity
  # :reek:TooManyStatements
  def process
    if opts.replay?
      replay
    elsif opts.reset?
      $current_battle.reset
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

  # :reek:TooManyStatements
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
        output.puts "#{result.first.character_name} has been killed." unless result.empty?
      end

      $current_battle.alive.each do |c|
        puts ">>> #{c}"
      end
      puts
    end
  end

  # :reek:NilCheck
  # :reek:TooManyStatements
  def replay
    output.puts 'No Battle to replay.' unless $current_battle
    output.puts "Replaying #{$current_battle.title}"

    instant_replay = Evercraft::Replay.new($current_battle)

    attack = instant_replay.step_forward

    until attack.nil?

      output.puts "Attack #{instant_replay.pointer}: "

      output.puts attack.to_yaml if opts.yaml?
      output.puts attack.to_s

      output.puts attack.attacker
      output.puts attack.target

      gets.chomp

      attack = instant_replay.step_forward
    end
  end
end
