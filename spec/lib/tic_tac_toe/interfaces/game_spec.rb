require 'spec_helper'

RSpec.describe TicTacToe::Interface::Game do
  describe '#greeting' do
    it 'should welcome the player(s)' do
      interface = TicTacToe::Interface::Game.new

      output = io_channel do
        interface.greeting
      end

      expect(output[0]).to be_a String
    end
  end

  describe '#total_players' do
    it 'should ask how many players will play' do
      interface = TicTacToe::Interface::Game.new

      output = io_channel do |ch|
        ch.set_input '3'
        interface.total_players
      end

      expect(output[0]).to be_a String
    end

    describe 'When there are two players' do
      it 'should return 2' do
        interface = TicTacToe::Interface::Game.new

        io_channel do |ch|
          ch.set_input '2'
          expect(interface.total_players).to be 2
        end
      end
    end
 
    describe 'When there are four players' do
      it 'should return 4' do
        interface = TicTacToe::Interface::Game.new

        io_channel do |ch|
          ch.set_input '4'
          expect(interface.total_players).to be 4
        end
      end
    end

    describe 'When an inalid option is given' do
      it 'should continue asking until a valid option is given' do
        interface = TicTacToe::Interface::Game.new
        
        output = io_channel do |ch|
          ch.set_input '4.2', 'boo', '3'
          interface.total_players
        end

        error_messages = output.select do |line|
          line.match /Sorry, but that is not a valid number/
        end

        expect(error_messages).to have_exactly(2).message
      end
    end
  end

  describe '#get_grid_size' do
    it 'should ask how large the grid should be' do
      interface = TicTacToe::Interface::Game.new

      output = io_channel do |ch|
        ch.set_input '2, 2'
        interface.get_grid_size        
      end

      expect(output[0]).to be_a String
    end

    describe 'and the player chooses 2 by 2' do
      it 'should return the size as an array' do
        interface = TicTacToe::Interface::Game.new
        
        io_channel do |ch|
          ch.set_input '2, 2'
          expect(interface.get_grid_size).to eq([2, 2])
        end
      end
    end

    describe 'and the player chooses 3 by 2' do
      it 'should return the size as an array' do
        interface = TicTacToe::Interface::Game.new
        
        io_channel do |ch|
          ch.set_input '3, 2'
          expect(interface.get_grid_size).to eq([3, 2])
        end
      end
    end

    describe 'When an inalid size is given' do
      it 'should continue asking until a valid option is given' do
        interface = TicTacToe::Interface::Game.new
        
        output = io_channel do |ch|
          ch.set_input '2.2, 2', 'boo', '3', '1, 2, 3', '4, 5'
          interface.get_grid_size
        end

        error_messages = output.select do |line|
          line.match /Sorry, but that is not a valid size/
        end

        expect(error_messages).to have_exactly(4).message
      end
    end

  end
end
