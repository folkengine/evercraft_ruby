require_relative '../../test_helper'

class TestReplay < Minitest::Test
  include Evercraft

  def setup
    @battle = Battle.test_factory_playout
    @replay = Replay.new(@battle)
  end

  def test_initialize
    alive = @replay.battle.alive.length
    assert_equal alive, 2
    attack = @replay.step_forward
    attack = @replay.step_forward until attack.nil?
    assert_equal @replay.battle.alive.length, 1
  end

  def test_replay
    attack = @replay.step_forward
    until attack.nil?
      @replay.replay.combatants
      attack = @replay.step_forward
      unless attack.nil?
        puts attack
        puts attack.attacker
        puts attack.target
      end
      puts
    end
    assert true
  end
end
