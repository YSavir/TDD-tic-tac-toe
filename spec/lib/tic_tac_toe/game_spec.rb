require 'spec_helper'

RSpec.describe TicTacToe::Game, :type => :model do

  describe '#create_grid' do
    describe 'when adding a 3x3 grid' do
      it 'should create an appropriate grid' do
        game = TicTacToe::Game.new
        expect(TicTacToe::Grid).to receive(:new).with(3, 3)
        
        game.create_grid(3, 3)
      end
    end

    describe 'when adding a 2x2 grid' do
      it 'should creat the appropriate grid' do
        game = TicTacToe::Game.new
        expect(TicTacToe::Grid).to receive(:new).with(2, 2)

        game.create_grid(2, 2)
      end
    end

    it 'should maintain access to the grid' do
      game = TicTacToe::Game.new
      grid = game.create_grid(3, 3)

      expect(game.grid).to be(grid)
    end
  end

  describe '#add_player' do
    describe 'when adding a human player' do
      it 'should create a new human player' do
        game = TicTacToe::Game.new
        expect(TicTacToe::Player).to receive(:new).with('X', true)

        io_channel do |channel|
          set_input! 'y', 'X'
          game.add_player
        end
      end

      describe 'and some symbols are already taken' do
        it 'should continue to ask for symbols until a valid one is given' do
          game = TicTacToe::Game.new
          io_channel do |channel|
            channel.set_input 'y', 'X'
            game.add_player
            channel.set_input 'y', 'X', 'O'
            game.add_player
          end

          expect(game.players.last.symbol).to eq('O')
        end
      end
    end
    
    describe 'when adding a computer player' do
      it 'should create a new computer player' do
        io_channel do |channel|
          channel.set_input 'n', 'X'
          game = TicTacToe::Game.new
          expect(TicTacToe::Player).to receive(:new).with('X', false)

          game.add_player
        end
      end
    end

    it 'should add the new player to the list of players' do
      game = TicTacToe::Game.new
      io_channel do |channel|
        channel.set_input 'y', 'X'
        game.add_player
      end

      expect(game.players).to have_exactly(1).player
    end

  end

  describe '#players' do
    describe 'when the game has two players' do
      it 'should return both player' do
        game = TicTacToe::Game.new
        io_channel do |channel|
          channel.set_input 'y', 'X'
          game.add_player
          channel.set_input 'y', 'O'
          game.add_player
        end

        expect(game.players).to have_exactly(2).players
      end
    end
  end

  describe '#create_grid' do
    describe 'when told to create a 3x3 grid' do
      it 'should create a grid with the given coordinates' do
        game = TicTacToe::Game.new

        expect(TicTacToe::Grid).to receive(:new).with(3, 3)
        game.create_grid(3, 3) 
      end

      it 'should store save the created grid' do
        game = TicTacToe::Game.new
        game.create_grid(3, 3)

        expect(game.grid).to be_a(TicTacToe::Grid)
      end
    end
  end

  describe '#turn_for' do
    it 'should get a cell the current player and fill it with that palayer\'s symbol' do
      game = build :game_with_grid
      player = build :computer_player

      game.turn_for(player) 

      expect(game.grid.cells_with_values).to have_exactly(1).cell
    end

    it 'should only fill in grids with no values' do
      game = build :game_with_grid
      player = build :human_player
      game.grid[1, 1].value = 'X'
      
      io_channel do |ch|
        ch.set_input '1, 1', '1, 2'
        game.turn_for(player)
      end

      expect(game.grid.cells_with_values).to have_exactly(2).cell
    end
  end

end
