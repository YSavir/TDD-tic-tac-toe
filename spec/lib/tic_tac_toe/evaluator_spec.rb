require 'spec_helper'

RSpec.describe TicTacToe::Evaluator do

  describe 'when initialized' do
    it 'should have a grid' do
      grid = build :grid
      evaluator = TicTacToe::Evaluator.new(grid)

      expect(evaluator.grid).to be grid
    end
  end

  describe '#check_win_for' do
    describe 'When passed an invalid object' do
      it 'should raise an error if the object is not a cell' do
        evaluator = build :evaluator_with_grid
        expected_error = /.* is not a cell/

        expect { evaluator.check_win_for('')}.to raise_error(expected_error)
      end

      it 'should raise an error if passed a cell not of its grid' do
        evaluator = build :evaluator_with_grid
        cell = build :cell_with_value
        expected_error = 'Cell is not part of grid'

        expect{ evaluator.check_win_for(cell) }.to raise_error(expected_error)
      end

      it 'should raise an error if passed a cell without a value' do
        evaluator = build :evaluator_with_grid
        cell = evaluator.grid[1, 1]
        expected_error = 'Cell must have a value to check for win'

        expect{ evaluator.check_win_for(cell) }.to raise_error(expected_error)
      end
    end

    describe 'without a winning combination' do
      it 'should return false' do
        evaluator = build :evaluator_with_grid
        cell = evaluator.grid[1, 1]
        cell.value = 'X'

        expect(evaluator.check_win_for(cell)).to be false
      end
    end

    describe 'When there is a horizontal winning combination' do
      it 'should return true' do
        evaluator = build :evaluator_with_grid
        grid = evaluator.grid
        grid[1, 1].value = 'X'
        grid[1, 2].value = 'X'
        grid[1, 3].value = 'X'

        expect(evaluator.check_win_for(grid[1, 1])).to be true
      end
    end

    describe 'When there is a vertical winning combination' do
      it 'should return true' do
        evaluator = build :evaluator_with_grid
        grid = evaluator.grid
        grid[1, 1].value = 'X'
        grid[2, 1].value = 'X'
        grid[3, 1].value = 'X'

        expect(evaluator.check_win_for(grid[1, 1])).to be true
      end
    end

    describe 'When there is a NW-SE winning combination' do
      it 'should return true' do
        evaluator = build :evaluator_with_grid
        grid = evaluator.grid
        grid[1, 1].value = 'X'
        grid[2, 2].value = 'X'
        grid[3, 3].value = 'X'

        expect(evaluator.check_win_for(grid[1, 1])).to be true
      end
    end
 
    describe 'When there is a NE-SW winning combination' do
      it 'should return true' do
        evaluator = build :evaluator_with_grid
        grid = evaluator.grid
        grid[1, 3].value = 'X'
        grid[2, 2].value = 'X'
        grid[3, 1].value = 'X'

        expect(evaluator.check_win_for(grid[1, 3])).to be true
      end
    end
 end

end
