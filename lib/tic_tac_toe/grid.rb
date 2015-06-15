class TicTacToe::Grid
  attr_reader :cells

  def initialize(rows, columns)
    @cells = []
    rows.times do |row_number|
      columns.times do |column_number|
        @cells << TicTacToe::Cell.new(row_number, column_number)
      end
    end
  end

  def [](x_coordinate, y_coordinate)
    @cells.find { |cell| cell.coordinates == [x_coordinate, y_coordinate] }
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
    output_string = "=================\n"
    output_string << rows.map do |row|
      row.map { |cell| cell.value.center(5) }.join('|')
    end.join("\n")
    output_string
  end


  private

  def rows
    return @rows if @rows
    last_row = @cells.map(&:row).max
    @rows = (0..last_row).map do |num|
      @cells.select { |c| c.row == num }.sort_by { |cell| cell.column }
    end
  end

end
