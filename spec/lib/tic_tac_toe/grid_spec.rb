require 'spec_helper'

RSpec.describe TicTacToe::Grid, :type => :model do

 describe 'When initializeing' do
    it 'should have the corrects number of cells' do
      grid_1 = TicTacToe::Grid.new 2, 2
      grid_2 = build :grid 

      expect(grid_1).to have_exactly(4).cells
      expect(grid_2).to have_exactly(9).cells
    end

    it 'should create cells with correct coordinates' do
      grid = build :grid 
      grid_coordinates = grid.cells.map(&:coordinates)
      expected_grid_coordinates = [[1, 1], [1, 2], [1, 3],
                                     [2, 1], [2, 2], [2, 3],
                                     [3, 1], [3, 2], [3, 3]]

      expect(grid_coordinates).to match_array(expected_grid_coordinates) 
    end
  end

  describe "#[]" do
    it 'should return the correct cell' do
      grid = build :grid 
      ones_cell = TicTacToe::Cell.new 1, 1     
      twos_cell = TicTacToe::Cell.new 2, 2
      
      expect(grid[1, 1]).to eq(ones_cell)
      expect(grid[2, 2]).to eq(twos_cell)
    end
  end

  describe '#cells_with_values' do
    describe 'with 2 cells with values' do
      it 'should return both of its cells with values' do
        grid = build :grid 
        grid[2, 2].value = 'O'
        grid[1, 1].value = 'X'
        
        expect(grid.cells_with_values).to match_array([grid[2, 2], grid[1, 1]])
      end
    end

    describe 'with 3 cells with values' do
      it 'should return all 3 of its cells with values' do
        grid = build :grid 
        grid[1, 1].value = 'O'
        grid[2, 2].value = 'X'
        grid[3, 3].value = 'O'
        
        expect(grid.cells_with_values).to match_array([grid[1, 1], grid[2, 2], grid[3, 3]])
      end
    end
  end

end
