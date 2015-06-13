require 'spec_helper'

RSpec.describe TicTacToe::Interface do
  after :each do
    reset_input!
    reset_output!
  end
  describe '#is_player_human?' do
    it 'should be true if the user chooses human' do
      set_input! 'y'
      capture_output!
      interface = TicTacToe::Interface.new

      expect(interface.is_player_human?).to be true
    end

    it 'should be false if the user chooses not human' do
      set_input! 'n'
      capture_output!
      interface = TicTacToe::Interface.new

      expect(interface.is_player_human?).to be false
    end

    it 'should continue to check humanity until a proper response is given' do
      set_input! 'boo', 'foo', 'y'
      capture_output!
      interface = TicTacToe::Interface.new
      interface.is_player_human?
      $stdout.rewind
      error_lines = $stdout.readlines.select do |line|
        line.match /Sorry, I didn\'t understand that./
      end
       
      expect(error_lines).to have_exactly(2).lines
   end
   
  end
end

