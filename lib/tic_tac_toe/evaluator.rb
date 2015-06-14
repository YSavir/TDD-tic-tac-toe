class TicTacToe::Evaluator
  attr_reader :grid

  def initialize(grid)
    @grid = grid  
  end

  def check_win_for(cell)
    validate(cell)
    true
  end

  private

  def validate(cell)
    raise "#{cell} is not a cell" unless cell.class == TicTacToe::Cell
    raise "Cell must have a value to check for win" unless cell.value
    raise "Cell is not part of grid" unless @grid.include? cell
  end
end
