class TicTacToe::Player
  attr_reader :symbol

  def initialize(symbol=nil, human=nil)
    @symbol = symbol
    @humanity = human
    @interface = TicTacToe::Interface::Player.new
  end

  def human?
    @humanity
  end

  def choose_cell_from(cells)
    human? ? pick_cell(cells) : cells.sample
  end

  def set_humanity
    @humanity = @interface.is_player_human?
  end

  def set_symbol(invalid_symbols)
    if human?
      @symbol = @interface.get_symbol(invalid_symbols)
    else
      @symbol = (symbols - invalid_symbols).first
    end
  end

  private

  def self.create_and_setup(invalid_symbols)
    player = new
    player.set_humanity
    player.set_symbol(invalid_symbols)
    return player
  end

  def pick_cell(cells)
    valid = false
    while !valid
      puts "Pick a cell. ('<row>, <column>')"
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
      puts "Sorry, #{response} is not a valid cell" unless valid
    end
    cell
  end

  def symbols
    ['X', 'O'] + ('A'..'Z').to_a
  end

end
