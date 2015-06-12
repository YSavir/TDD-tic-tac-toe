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
    cells.select { |cell| cell.value }
  end

end
