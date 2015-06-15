class TicTacToe::Cell
  attr_reader :row, :column
  attr_reader :value
  include Comparable

  def initialize(row, column)
    @row = row
    @column = column
  end

  def coordinates
    [@row, @column]
  end

  def ==(other)
    other.is_a?(self.class) && coordinates == other.coordinates
  end

  def value=(new_value)
    if @value
      raise('Cells with values cannot have their values changed')
    else
      @value = new_value
    end
  end

end

