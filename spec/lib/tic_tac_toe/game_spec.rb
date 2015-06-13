require 'spec_helper'

RSpec.describe TicTacToe::Game, :type => :model do
  # Allows for presetting a gets input
  # Join multiple strings with a newline so they are gets'ed individually
  def set_input!(*values)
    $stdin = StringIO.new(values.join("\n"))
  end

  def reset_input!
    @stdin = STDIN
  end

  # Allows for inspecting output
  def capture_output!
    $stdout = StringIO.new
  end
  def reset_output!
    $stdout = STDOUT
  end

  after :each do
    reset_output!
    reset_input!
  end

  describe '#add_player' do
    before :each do
      capture_output!
    end

    it 'should create a new player' do
      set_input! 'y', 'X'
      game = TicTacToe::Game.new
      expect(TicTacToe::Player).to receive(:new).with('X', true)

      game.add_player
    end

    it 'should add the new player to the list of players' do
      set_input! 'y', 'X'
      game = TicTacToe::Game.new
      game.add_player

      expect(game.players).to have_exactly(1).players
      
      set_input! 'y', 'O'
      game.add_player

      expect(game.players).to have_exactly(2).players
    end
  end

  describe '#generate_grid' do
    describe 'when told to create a 3x3 grid' do
      it 'should create a grid with the given ' do
      end
    end
  end

end
