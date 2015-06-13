class TicTacToe::Player
  attr_reader :symbol
  
  def initialize(game)
    @game = game
    check_humanity
    get_symbol
  end

  def human?
    @humanity
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
    @humanity = human_options.include? response
  end

  def get_symbol
    @symbol = human? ? symbol_for_human : symbol_for_computer
  end

  def symbol_for_human
    response = nil
    unavailable_symbols = @game.symbols_in_use + [nil]
    invalid = true
    while invalid
      $stdout.puts 'What symbol would you like to use?'
      response = $stdin.gets.strip
      invalid = (unavailable_symbols.include? response)
      $stdout.puts "Sorry, #{response} is already taken." if invalid 
    end
    @symbol = response
  end

  def symbol_for_computer
    available_symbols = ['X'] + ('A'..'Z').to_a - @game.symbols_in_use
    available_symbols.first
  end

end
