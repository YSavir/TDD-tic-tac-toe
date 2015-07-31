class TicTacToe::Grid
  attr_reader :cells

  def initialize(height, width)
    @cells = []
    @height, @width = height, width
    generate_rows
    generate_cells
  end

  def [](row, column)
    @cells.find { |cell| cell.coordinates == [row, column] }
  end

  def cells_with_values
    cells.select { |cell| !cell.value.empty? }
  end

  def available_cells
    cells.select { |cell| cell.value.empty? }
  end

  def include?(other)
    @cells.each do |cell|
      return true if cell.equal? other
    end
    false
  end

  def to_s
    header + rows.map { |k, v| v.to_s } .join(line_break)
  end

  def rows
    @rows ||= {}
  end

  private

  def add_cell(row, column)
    new_cell = TicTacToe::Cell.new(row, column)
    @cells << new_cell
    rows[row].add_cell new_cell
  end

  def header
    col_string = col_values.map(&:to_s)
        .map { |col| col.center(5) }
        .join('|')
    output_string = 'R\C'.center(5)
    output_string += col_string
    output_string << "\n\n"
  end
 
  def line_break
    "\n" + ('-----' * (@width + 1)) + "\n"
  end
 
  def generate_cells
    coordinates.each do |(row, col)|
      add_cell(row, col)
    end
  end

  def generate_rows
    @height.times do |num|
      num += 1
      rows[num] = TicTacToe::Row.new(num)
    end
  end

  # an array of arrays with coordinate pairs
  def coordinates
    row_values.product(col_values)
  end

  def row_values
    (1..@height).to_a
  end

  def col_values
    (1..@width).to_a
  end

end
