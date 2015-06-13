require 'spec_helper'

RSpec.describe TicTacToe::Player, :type => :model do

  # Allows for presetting a gets input
  # Join multiple strings with a newline so they are gets'ed individually
  def set_input!(*values)
    $stdin = StringIO.new(values.join("\n"))
  end

  def reset_input!
    @stdin = STDIN
  end

  # Allows for inspecting output
  def capture_output!
    $stdout = StringIO.new
  end
  def reset_output!
    $stdout = STDOUT
  end
  Game = Struct.new(:symbols_in_use)

  before :each do
    capture_output!
    @game ||= Game.new([])
  end
  after :each do
    reset_input!
    reset_output!
  end

  describe 'When initialized' do
    describe 'as a human player' do
      it 'should be human' do
        set_input! "y", "X"
        player = TicTacToe::Player.new(@game)

        expect(player.human?).to be true
      end

      describe 'and the player is asked to input a symbol' do
        it 'should accept X as a symbol' do
          set_input! "y", "X"
          player = TicTacToe::Player.new(@game)
          
          expect(player.symbol).to eq('X') 
        end

        it 'should accept anything symbol' do
          set_input! "y", "☯"
          player = TicTacToe::Player.new(@game)
          
          expect(player.symbol).to eq('☯') 
        end

        describe 'and multiple symbols have already been chosen' do
          it 'should continue to ask for a symbol until a new one is given' do
            set_input! "y", "X", "O", "☯"
            game = Game.new(["X", "O"])
            TicTacToe::Player.new game
            $stdout.rewind
            error_lines = $stdout.readlines.select do |line|
              line.match /Sorry, (.) is already taken./
            end

            expect(error_lines).to have_exactly(2).lines
          end
        end
      end

    end

    describe 'as a computer player' do
      it 'should not be human' do
        set_input! "n"
        player = TicTacToe::Player.new(@game)

        expect(player.human?).to be false
      end

      it 'should choose \'X\' as a symbol' do
        set_input! 'n'
        player = TicTacToe::Player.new(@game)
        
        expect(player.symbol).to eq('X')
      end

      describe 'and multiple symbols have already been chosen' do
        it 'should pick a symbol other than those symbols' do
          set_input! "n", "A", "B", "C"
          game = Game.new(['X', 'A', 'B'])
          player = TicTacToe::Player.new(game)
           
          expect(player.symbol).to eq('C')
        end
      end
    end

    describe 'as an invalid player type' do
      it 'should continue to ask for type until a valid reponse is given' do
        set_input! "nope", "fjdio", "hfjidoa", "y", "X"
        capture_output!
        TicTacToe::Player.new(@game)
        $stdout.rewind
        error_lines = $stdout.readlines.select { |line| line.match /Sorry, I didn\'t understand that./ }
         
        expect(error_lines).to have_exactly(3).lines
      end
    end

  end

end
