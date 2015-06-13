class TicTacToe::Game
  attr_reader :players

  def initialize
    @interface = TicTacToe::Interface.new
    @players = []
    @symbols_in_use = []
  end

  def add_player
    human = @interface.is_player_human?
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
