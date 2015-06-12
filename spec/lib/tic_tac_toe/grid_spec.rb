require 'spec_helper'

RSpec.describe TicTacToe::Grid, :type => :model do
 before :all do
   @grid_1 = TicTacToe::Grid.new 2, 2
   @grid_2 = TicTacToe::Grid.new 3, 3
 end

 describe 'When initializeing' do
    it 'should have the corrects number of cells' do
      expect(@grid_1).to have_exactly(4).cells
      expect(@grid_2).to have_exactly(9).cells
    end

    it 'should create cells with correct coordinates' do
      grid_2_coordinates = @grid_2.cells.map(&:coordinates)
      expected_grid_2_coordinates = [[0, 0], [0, 1], [0, 2],
                                     [1, 0], [1, 1], [1, 2],
                                     [2, 0], [2, 1], [2, 2]]
      expect(grid_2_coordinates).to match_array(expected_grid_2_coordinates) 
    end
  end

  describe "#[]" do
    it 'should return the correct cell' do
      ones_cell = TicTacToe::Cell.new 1, 1     
      zeros_cell = TicTacToe::Cell.new 0, 0
      
      expect(@grid_1[1, 1]).to eq(ones_cell)
      expect(@grid_1[0, 0]).to eq(zeros_cell)
    end
  end

end
