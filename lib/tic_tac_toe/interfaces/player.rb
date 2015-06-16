class TicTacToe::Interface::Player

  def is_player_human?
    valid_response = false
    until valid_response
      $stdout.puts "Is this a human player? (y/n)"
      response = $stdin.gets.strip
      valid_response = valid_options.include?(response)
      $stdout.puts "Sorry, I didn\'t understand that." unless valid_response
    end
    return valid_human_options.include? response
  end

  def get_symbol(invalid_symbols=[])
    valid_response = false
    until valid_response
      $stdout.puts "What symbol would you like to use?"
      response = $stdin.gets.strip
      valid_response = !invalid_symbols.include?(response)
      $stdout.puts "Sorry, #{response} is already taken" unless valid_response
    end
    return response
  end
  
  def get_cell(cells)
    valid = false
    until valid
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

  private

  def valid_human_options
    ['yes', 'y']
  end

  def valid_computer_options
    ['no', 'n']
  end

  def valid_options
    valid_human_options + valid_computer_options
  end

end
