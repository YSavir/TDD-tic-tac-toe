class TicTacToe::Game
  attr_reader :players

  def initialize
    @players = []
    @symbols_in_use = []
  end

  def add_player
    human = check_humanity
    symbol = human ? symbol_for_human : symbol_for_computer
    @players << TicTacToe::Player.new(symbol, human)
  end

  def symbols_in_use
    []
  end

  def players
    @players
  end

  private

  def check_humanity
    response = nil
    human_options = ['yes', 'y']
    computer_options = ['no', 'n']
    options = human_options + computer_options
    while !options.include? response
      $stdout.puts "Is this a human player? (y/n)"
      response = $stdin.gets.strip
      puts "Sorry, I didn\'t understand that." unless options.include? response 
    end
    return human_options.include? response
  end

  def symbol_for_human
    response = nil
    invalid = true
    while invalid
      $stdout.puts 'What symbol would you like to use?'
      response = $stdin.gets.strip
      invalid = @symbols_in_use.include?(response)
      $stdout.puts "Sorry, #{response} is already taken." if invalid 
    end
    return response
  end

  def symbol_for_computer
    available_symbols = ['X'] + ('A'..'Z').to_a - @symbols_in_use
    available_symbols.first
  end


  

end
