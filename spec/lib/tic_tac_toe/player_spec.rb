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

#      describe 'and the player is asked to input a symbol' do
#        it 'should accept X as a symbol' do
#          set_input! "y", "X"
#          player = TicTacToe::Player.new(@game)
#          
#          expect(player.symbol).to eq('X') 
#        end
#
#        it 'should accept anything symbol' do
#          set_input! "y", "☯"
#          player = TicTacToe::Player.new(@game)
#          
#          expect(player.symbol).to eq('☯') 
#        end
#      end
#    end
#
#    describe 'as a computer player' do
#      it 'should not be human' do
#        player = TicTacToe::Player.new('X', false)
#
#        expect(player.human?).to be false
#      end
#
#      describe 'and multiple symbols have already been chosen' do
#        it 'should pick a symbol other than those symbols' do
#          set_input! "n", "A", "B", "C"
#          game = Game.new(['X', 'A', 'B'])
#          player = TicTacToe::Player.new(game)
#           
#          expect(player.symbol).to eq('C')
#        end
#      end
#    end
#
#    describe 'as an invalid player type' do
#      it 'should continue to ask for type until a valid reponse is given' do
#        set_input! "nope", "fjdio", "hfjidoa", "y", "X"
#        capture_output!
#        TicTacToe::Player.new(@game)
#        $stdout.rewind
#        error_lines = $stdout.readlines.select { |line| line.match /Sorry, I didn\'t understand that./ }
#         
#        expect(error_lines).to have_exactly(3).lines
#      end
#    end
#
#  end

end
