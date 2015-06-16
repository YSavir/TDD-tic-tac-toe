class TicTacToe::Player
  attr_reader :symbol

  def initialize(symbol=nil, human=nil)
    @symbol = symbol
    @humanity = human
  end

  def human?
    @humanity
  end

  def choose_cell_from(cells)
    human? ? pick_cell(cells) : cells.sample
  end

  def set_humanity
    @humanity = interface.is_player_human?
  end

  def set_symbol(invalid_symbols)
    if human?
      @symbol = interface.get_symbol(invalid_symbols)
    else
      @symbol = valid_symbols(invalid_symbols).first
    end
  end

  private

  def interface
    @interface ||= TicTacToe::Interface::Player.new
  end

  def self.create_and_setup(invalid_symbols)
    player = new
    player.set_humanity
    player.set_symbol(invalid_symbols)
    return player
  end

  def pick_cell(cells)
    interface.get_cell(cells)
  end

  def symbols
    ['X', 'O'] + ('A'..'Z').to_a
  end

  def valid_symbols(invalid_symbols)
    symbols - invalid_symbols
  end

end

