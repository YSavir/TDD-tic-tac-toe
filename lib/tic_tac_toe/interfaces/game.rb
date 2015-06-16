class TicTacToe::Interface::Game

  def greeting
    puts 'Welcome to Tic Tac Tobject Oriented O'
  end

  def total_players
    valid = false
    until valid
      puts "How many players?"
      response = $stdin.gets.strip
      num = response.to_i
      valid = true unless num.to_s != response
      puts 'Sorry, but that is not a valid number' unless valid
    end
    return num
  end

  def get_grid_size
    valid = false
    until valid
      puts 'What size should the grid be? (eg. \'2, 2\' or \'10, 20\')'
      sizes_string = $stdin.gets.strip
      sizes = sizes_string.split(', ').map(&:to_i)
      valid = true unless sizes.length != 2 || sizes.map(&:to_s).join(", ") != sizes_string
      puts 'Sorry, but that is not a valid size' unless valid
    end
    return sizes
  end
end
