class TicTacToe::Evaluator
  attr_reader :grid

  def initialize(grid)
    @grid = grid  
  end

  def check_win_for(cell)
    validate(cell)
    neighbors_with_same_value = find_neighbors_with_same_value(cell)

    possible_sequences = neighbors_with_same_value.map do |neighbor|
      TicTacToe::Sequence.from_cells(@grid, cell, neighbor)
    end.flatten
    
    possible_sequences.any?(&:valid?)
  end

  private

  def find_neighbors(cell)
    neighbor_modifiers.map do |coord_mods|
      row = cell.row + coord_mods[0]
      column = cell.column + coord_mods[1]
      @grid[row, column]
    end.compact
  end

  def find_neighbors_with_same_value(cell)
    find_neighbors(cell).select do |neighbor|
      cell.value == neighbor.value
    end
  end

  def validate(cell)
    raise "#{cell} is not a cell" unless cell.class == TicTacToe::Cell
    raise "Cell must have a value to check for win" if cell.value.empty?
    raise "Cell is not part of grid" unless @grid.include? cell
  end

  def neighbor_modifiers
    mods = (-1..1).to_a.repeated_permutation(2).to_a
    mods.delete([0, 0])
    mods
  end
end

