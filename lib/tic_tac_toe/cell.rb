class TicTacToe::Cell
  attr_reader :x_coordinat, :y_coordinate
  attr_accessor :value

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

end

