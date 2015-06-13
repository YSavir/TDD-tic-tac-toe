class TicTacToe::Interface

  def is_player_human?
    valid_response = false
    until valid_response
      $stdout.puts "Is this a human player? (y/n)"
      response = $stdin.gets.strip
      valid_response = valid_options.include?(response)
      puts "Sorry, I didn\'t understand that." unless valid_response
    end
    return valid_human_options.include? response
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
