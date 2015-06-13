require 'spec_helper'

RSpec.describe TicTacToe::Game, :type => :model do
  after :each do
    reset_output!
    reset_input!
  end

  describe '#add_player' do
    describe 'when adding a human player' do
      it 'should create a new human player' do
        capture_output!
        set_input! 'y', 'X'
        game = TicTacToe::Game.new

        expect(TicTacToe::Player).to receive(:new).with('X', true)

        game.add_player
      end

      describe 'and some symbols are already taken' do
        it 'should continue to ask for symbols until a valid one is given' do
          capture_output!
          game = TicTacToe::Game.new
          set_input! 'y', 'X'
          game.add_player
          set_input! 'y', 'X', 'O'
          game.add_player

          expect(game.players.last.symbol).to eq('O')
        end
      end
    end
    
    describe 'when adding a computer player' do
     it 'should create a new computer player' do
        set_input! 'n', 'X'
        game = TicTacToe::Game.new

        expect(TicTacToe::Player).to receive(:new).with('X', false)

        game.add_player
      end
    end

    it 'should add the new player to the list of players' do
      set_input! 'y', 'X'
      capture_output!
      game = TicTacToe::Game.new
      game.add_player

      expect(game.players).to have_exactly(1).players
    end

  end

  describe '#players' do
    describe 'when the game has two players' do
      it 'should return both player' do
        game = TicTacToe::Game.new
        capture_output!
        set_input! 'y', 'X'
        game.add_player
        set_input! 'y', 'O'
        game.add_player

        expect(game.players).to have_exactly(2).players
      end
    end
  end

  describe '#generate_grid' do
    describe 'when told to create a 3x3 grid' do
      it 'should create a grid with the given ' do
      end
    end
  end

end
