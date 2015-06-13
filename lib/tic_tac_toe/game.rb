class TicTacToe::Game
  attr_reader :players, :grid

  def initialize
    @interface = TicTacToe::Interface.new
    @players = []
  end

  def add_player
    human = @interface.is_player_human?
    symbol = human ? @interface.get_symbol(symbols_in_use) : get_computer_symbol
    @players << TicTacToe::Player.new(symbol, human)
  end

  def create_grid(rows, columns)
    @grid = TicTacToe::Grid.new(rows, columns)
  end

  def players
    @players
  end

  private

  def get_computer_symbol
    available_symbols.first
  end

  def available_symbols
    ['X'] + ('A'..'Z').to_a - symbols_in_use
  end

  def symbols_in_use
    players.map(&:symbol)
  end

end
