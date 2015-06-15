class TicTacToe::Cell
  attr_reader :row, :column
  attr_reader :value
  include Comparable

  def initialize(row, column)
    @row = row
    @column = column
    @value = ''
  end

  def coordinates
    [@row, @column]
  end

  def ==(other)
    other.is_a?(self.class) && coordinates == other.coordinates
  end

  def value=(new_value)
    @value = new_value if new_value.is_a? String
  end

end

