module TicTacToe
  class Row
    attr_reader :index, :cells

    def initialize(index)
      @index = index
      @cells = []
    end

    def add_cell(cell)
      @cells << cell
    end

    def to_s
      row_index = "#{@index}".center(5)
      values_string = @cells.map { |cell| cell.value.center(5) }.join('|')
      return row_index + values_string
    end

  end
end
