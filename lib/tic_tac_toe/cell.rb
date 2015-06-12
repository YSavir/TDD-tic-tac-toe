class TicTacToe::Cell
  attr_accessor :value

  def initialize(x_coordinate, y_coordinate)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
  end

  def coordinates
    [@x_coordinate, @y_coordinate]
  end

end

