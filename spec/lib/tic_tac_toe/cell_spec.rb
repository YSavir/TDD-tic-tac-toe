require 'spec_helper'

RSpec.describe TicTacToe::Cell, :type => :model do
  describe '#coordinates' do
    it "should return the cell\'s coordinates" do
      cell_1 = TicTacToe::Cell.new 1, 1
      cell_2 = TicTacToe::Cell.new 2, 2
      expect(cell_1.coordinates).to eq([1, 1])
      expect(cell_2.coordinates).to eq([2, 2])
    end
  end

  describe '#value' do
    it "should return the cell\'s value" do
      cell_1 = TicTacToe::Cell.new 1, 1
      cell_2 = TicTacToe::Cell.new 2, 2
      cell_1.value = 'x' 
      cell_2.value = 'y' 
       
      expect(cell_1.value).to eq('x')
      expect(cell_2.value).to eq('y')
    end

    it "should raise an error if the cell already has a value" do
      a = TicTacToe::Cell.new 1, 1
      a.value = 'x'
      error_message = 'Cells with values cannot have their values changed'

      expect {a.value = 'y'}.to raise_error(error_message)
    end
  end

end
