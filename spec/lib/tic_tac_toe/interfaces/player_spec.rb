require 'spec_helper'

RSpec.describe TicTacToe::Interface::Player do
  
  describe '#is_player_human?' do
    it 'should be true if the user chooses human' do
      interface = TicTacToe::Interface::Player.new

      io_channel do |ch|
        ch.set_input 'y'
        expect(interface.is_player_human?).to be true
      end
    end

    it 'should be false if the user chooses not human' do
      interface = TicTacToe::Interface::Player.new

      io_channel do |ch|
        ch.set_input 'n'
        expect(interface.is_player_human?).to be false
      end
    end

    it 'should continue to check humanity until a proper response is given' do
      interface = TicTacToe::Interface::Player.new

      output = io_channel do |ch|
        ch.set_input 'boo', 'foo', 'y'
        interface.is_player_human?
      end

      error_lines = output.select do |line|
        line.match /Sorry, I didn\'t understand that./
      end
       
      expect(error_lines).to have_exactly(2).lines
   end
  end

  describe '#get_symbol' do
    describe 'with a human player' do
      describe 'and the player chooses \'☯\'' do
        it 'should return \'☯\'' do
          interface = TicTacToe::Interface::Player.new

          io_channel do |ch|
            ch.set_input'☯'
            expect(interface.get_symbol).to eq('☯')
          end
        end
      end

      describe 'and the player chooses \'X\'' do
        it 'should return \'X\'' do
          interface = TicTacToe::Interface::Player.new

          io_channel do |ch|
            ch.set_input 'X'
            expect(interface.get_symbol).to eq('X')
          end
        end

        describe 'but X is already taken' do
          it 'should wait until an unused symbol is given' do
            interface = TicTacToe::Interface::Player.new

            output = io_channel do |ch|
              ch.set_input 'X', 'X', '☯'
              interface.get_symbol(['X'])
            end

            error_lines = output.select do |line|
              line.match /Sorry, . is already taken/
            end
       
            expect(error_lines).to have_exactly(2).lines
          end
        end
      end

    end
  end
end

