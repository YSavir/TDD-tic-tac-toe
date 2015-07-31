require 'spec_helper'

RSpec.describe TicTacToe::Row, :type => :model do
  describe 'when initialized' do
    it 'should require an index argument' do
      expect { TicTacToe::Row.new }.to raise_error(ArgumentError)
    end
  end

  describe '#index' do
    it 'should return the row\'s index' do
      row0 = TicTacToe::Row.new(0)
      row1 = TicTacToe::Row.new(1)

      expect(row0.index).to be 0
      expect(row1.index).to be 1
    end
  end

  describe '#add_cell' do
    it 'should add a given cell to the row' do
      row = build :row
      cell = build :cell

      row.add_cell(cell)
      
      expect(row.cells).to include cell
    end
  end

  describe '#to_s' do
    it 'should return the string formatted for output' do
      rows= build_list :row_with_cells, 2

      matcher = /  \d    X  \|  X  \|  X  /

      expect(rows[0].to_s).to match matcher
      expect(rows[1].to_s).to match matcher
    end
  end

end

