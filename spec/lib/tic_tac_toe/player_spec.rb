require 'spec_helper'

RSpec.describe TicTacToe::Player, :type => :model do

  describe 'When initialized' do
    describe 'as a human player' do
      it 'should be human' do
        player = TicTacToe::Player.new('X', true)

        expect(player.human?).to be true
      end
    end

    describe 'as a computer player' do
      it 'should not be human' do
        player = TicTacToe::Player.new('X', false)

        expect(player.human?).to be false
      end
    end

    describe 'with \'X\' as a symbol' do
      it 'should have \'X\' as a symbol' do
        player = TicTacToe::Player.new('X', true)
        
        expect(player.symbol).to eq('X')
      end
    end

    describe 'with \'☯\' as a symbol' do
      it 'should have \'☯\' as a symbol' do
        player = TicTacToe::Player.new('☯', true)

        expect(player.symbol).to eq('☯')
      end
    end
  end

  describe '#choose_cell' do
    describe 'when the player is a computer' do
      it 'should pick a random cell' do
        cells = []
        5.times { cells << TicTacToe::Cell.new(1,1) }
        player = TicTacToe::Player.new('X', false)
        expect(cells).to include(player.choose_cell(cells))
      end
    end

    describe 'when the player is human' do
      it 'should let the player pick a cell' do
        grid = TicTacToe::Grid.new(3, 3)
        available_cells = grid.available_cells
        player = TicTacToe::Player.new('X', true)
        set_input! '0, 0'

        expect(player.choose_cell(available_cells)).to be(grid[0,0])
      end

      it 'should continue to ask until the player picks a valid cell' do
        grid = TicTacToe::Grid.new(3, 3)
        player = TicTacToe::Player.new('X', true)
        set_input! '4, 4', 'some, gibberish', 'gibberish', '4', '2, 2'
        capture_output!
        player.choose_cell(grid.available_cells)
        $stdout.rewind
        error_lines = $stdout.readlines.select do |line|
          line.match /Sorry, .* is not a valid cell/
        end

        expect(error_lines).to have_exactly(4).lines
      end
    end
  end

end
