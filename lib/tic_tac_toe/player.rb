class TicTacToe::Player
  attr_reader :symbol
  
  def initialize(symbol, human)
    @symbol = symbol
    @humanity = human
  end

  def human?
    @humanity
  end

  def choose_cell(cells)
    human? ? pick_cell(cells) : cells.sample
  end

  private

  def pick_cell(cells)
    valid = false
    while !valid
      $stdout.puts "Pick a cell. ('<row>, <column>')"
      response = $stdin.gets.strip
      coordinates = response.delete('').split(',').map(&:to_i)
      reversed = coordinates.join(', ')
      valid_amount = coordinates.length == 2
      valid_types = reversed == response      
      valid_conditions = valid_amount && valid_types
      if valid_conditions
        cell = cells.find{ |cell| cell.coordinates == coordinates }
        valid = true if cell
      end
      $stdout.puts "Sorry, #{response} is not a valid cell" unless valid
    end
    cell
  end

end
