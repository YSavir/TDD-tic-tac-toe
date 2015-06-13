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

end
