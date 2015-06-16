class TicTacToe::Grid
  attr_reader :cells

  def initialize(rows, columns)
    @cells = []
    @height = rows
    @width = columns
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
    output_string = header
    output_string << rows.map do |row|
      row_to_string(row)
    end.join(line_break)
    output_string
  end


  private

  def add_cell(row, column)
    @cells << TicTacToe::Cell.new(row, column)
  end

  def header
    col_string = col_values.map(&:to_s)
                  .map { |col| col.center(5) }
                  .join('|')
    output_string = 'R\C'.center(5)
    output_string += col_string
    output_string << "\n\n"
  end

  def row_to_string(row)
    row_index = row[0].row.to_s.center(5)
    values_string = row.map { |cell| cell.value.center(5) }.join('|')
    return row_index + values_string
  end
 
  def line_break
    "\n" + ('-----' * (@width + 1)) + "\n"
  end
 
  def generate_cells
    coordinates.each do |(row, col)|
      add_cell(row, col)
    end
  end

  def rows
    return @rows if @rows
    row_values.map do |val|
      @cells.select { |c| c.row == val }.sort_by(&:column)
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
