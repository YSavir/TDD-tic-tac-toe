class TicTacToe::Cell
  attr_reader :x_coordinat, :y_coordinate
  attr_reader :value

  def initialize(x_coordinate, y_coordinate)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
  end

  def coordinates
    [@x_coordinate, @y_coordinate]
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

