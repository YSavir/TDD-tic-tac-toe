require 'spec_helper'

RSpec.describe TicTacToe::Game, :type => :model do

  describe 'when initialized' do
    it 'should not be complete' do
      game = build :game

      expect(game.complete?).to be false
    end
  end

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
    it 'should create a new player' do
      game = TicTacToe::Game.new
      expect(TicTacToe::Player).to receive(:create_and_setup)

      game.add_player
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
  
    it 'should add the new player to the list of players' do
      game = TicTacToe::Game.new
      player = build :human_player
      allow(TicTacToe::Player).to receive(:create_and_setup) { player }
      game.add_player

      expect(game.players).to have_exactly(1).player
    end

  end

  describe '#players' do
    describe 'when the game has two players' do
      it 'should return both player' do
        game = TicTacToe::Game.new
        allow(TicTacToe::Player).to receive(:create_and_setup) { build(:player) }

        game.add_player
        game.add_player
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
    it 'should get a cell from the current player and fill it with that player\'s symbol' do
      game = build :game_with_grid
      game.players << build(:computer_player)

      game.turn_for(game.players.first) 

      expect(game.grid.cells_with_values).to have_exactly(1).cell
    end

    it 'should only fill in grids with no values' do
      game = build :game_with_grid_and_human_player
      game.grid[1, 1].value = 'X'
      
      io_channel do |ch|
        ch.set_input '1, 1', '1, 2'
        game.turn_for(game.players.first)
      end

      expect(game.grid.cells_with_values).to have_exactly(2).cell
    end

    it 'should show the grid' do
      game = build :game_with_grid_and_human_player
      expect(game.grid).to receive(:to_s)

      io_channel do |ch|
        ch.set_input '1, 1'
        game.turn_for(game.players.first)
      end
    end

    it 'should check if that move ended the game' do
      game = build :game_with_grid_and_human_player
      game.grid[0, 0].value = 'X'
      game.grid[0, 1].value = 'X'
      
      output = io_channel do |ch|
        ch.set_input '0, 2'
        game.turn_for(game.players.first) 
      end

      expect(output.join(' ')).to match /X won!/
    end

    describe 'if the turn wins the game' do
      it 'should end the game' do
        game = build :game_with_grid_and_human_player
        game.grid[0, 0].value = 'X'
        game.grid[0, 1].value = 'X'
        
        output = io_channel do |ch|
          ch.set_input '0, 2'
          game.turn_for(game.players.first) 
        end

        expect(game.complete?).to be true
      end
    end
  end

  describe '#start!' do
    describe 'When played until someone has won' do
      it 'should declare the winner' do
        game = build :game_with_grid_and_computer_player

        output = io_channel do
          game.start!
        end
        
        expect(output.join(' ')).to match /X won!/
      end

      it 'should not declare a tie' do
        game = build :game_with_grid_and_computer_player

        output = io_channel do
          game.start!
        end
        expect(output.join(' ')).not_to match /It's a tie!/
      end
    end

    describe 'When played until no moves are left' do
      it 'should declare a tie' do
        game = build :game_with_grid_and_human_player
        game.players << TicTacToe::Player.new('O', true)

        output = io_channel do |ch|
          ch.set_input "0, 2", "0, 0", "1, 0", "0, 1", "1, 1", "1, 2", "2, 1", "2, 0", "2, 2"
          game.start! :no_shuffle => true
        end

        expect(output.join(' ')).to match /It's a tie!/
      end

      it 'should not declare a winner' do
        game = build :game_with_grid_and_human_player
        game.players << TicTacToe::Player.new('O', true)
        all_coordinates = (0..2).to_a.repeated_permutation(2).map { |c| c.join(', ') }
        
        output = io_channel do |ch|
          ch.set_input "0, 2", "0, 0", "1, 0", "0, 1", "1, 1", "1, 2", "2, 1", "2, 0", "2, 2"
          game.start! :no_shuffle => true
        end

        expect(output.join(' ')).not_to match /. won!/
      end
    end
  end

  describe '#setup' do
    it 'should set up for the game' do
      game = TicTacToe::Game.new
      expect(TicTacToe::Player).to receive(:create_and_setup).twice {build :human_player}
      expect(TicTacToe::Grid).to receive(:new).with(3, 3)

      io_channel do |ch|
        ch.set_input '2', '3, 3', 'y', 'X', 'n'
        game.setup
      end
    end
  end

end
