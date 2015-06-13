class TicTacToe::Player
  attr_reader :symbol
  
  def initialize(symbol, human)
    @symbol = symbol
    @humanity = human
  end

  def human?
    @humanity
  end

end
