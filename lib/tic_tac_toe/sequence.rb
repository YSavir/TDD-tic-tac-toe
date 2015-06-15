class TicTacToe::Sequence

  def initialize(cells)
    @cells = cells
  end

  def self.from_cells(grid, *cells)
    direction = find_direction_for(cells)
    sequences = complete_sequence_in(direction, grid, cells).compact
  end

  def valid?
    @cells.all? { |cell| cell.value == @cells[0].value }
  end
  
  private

  def self.find_direction_for(cells)
    first_cell, last_cell = cells.first, cells.last
    if first_cell.row == last_cell.row
      :horizontal
    elsif first_cell.column == last_cell.column
      :vertical
    else
      get_diagonal(first_cell, last_cell)
    end
  end

  def self.get_diagonal(cell, other)
    # If the product of both coordinate totals is positive, its a down_right
    # diagonal. Otherwise its a down_left. Identical rows or columns would
    # screw this up, but this shouldn't be called if either are identical
    row_total = cell.row - other.row
    column_total = cell.column - other.column
    product = row_total * column_total
    return product > 0 ? :down_right : :down_left
  end

  def self.complete_sequence_in(direction, grid, cells)
    case direction
    when :horizontal
      complete_horizontal_sequence(grid, cells)
    when :vertical
      complete_vertical_sequence(grid, cells)     
    else
      return complete_diagonal(grid, cells, direction)
    end
  end

  def self.create_sequence(row, column, grid, cells)
    cell = grid[row, column]
    if cell
      cells.push cell
      new(cells)
    else
      nil
    end
  end

  def self.complete_horizontal_sequence(grid, cells)
    columns = cells.map(&:column)
    row = cells[0].row
    # iterate over the columns before and after the cells and create new
    # sequence.
    return [columns.min - 1, columns.max + 1].map do |column|
      create_sequence row, column, grid, cells
    end
  end

  def self.complete_vertical_sequence(grid, cells)
    rows = cells.map(&:row)
    column = cells[0].column
    # iterate over the rows before and after the cells and create new
    # sequence.
    return [rows.min - 1, rows.max + 1].map do |row|
      create_sequence row, column, grid, cells
    end
  end

  def self.complete_diagonal(grid, cells, direction)
    rows, columns = [cells.first.coordinates, cells.last.coordinates].transpose
    coordinates = coordinates_for_diagonals(rows, columns, direction)
    coordinates.map do |coord|
      create_sequence coord[0], coord[1], grid, cells
    end
  end

  def self.coordinates_for_diagonals(rows, columns, direction)
    case direction
    when :down_right
      return [
        [rows.min - 1, columns.min - 1],
        [rows.max + 1, columns.max + 1]
      ]
    when :down_left
      return [
        [rows.max + 1, columns.min - 1],
        [rows.min - 1, columns.max + 1]
      ]
    end
  end
end

