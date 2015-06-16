class TicTacToe::Game
  attr_reader :players, :grid

  def initialize
    interface = TicTacToe::Interface::Game.new
    @players = []
    @complete = false
  end

  def add_player
    puts "Setting up player ##{@players.length + 1}"
    @players << TicTacToe::Player.create_and_setup(symbols_in_use)
  end

  def create_grid(rows, columns)
    @grid = TicTacToe::Grid.new(rows, columns)
  end

  def setup
    total_players = interface.total_players
    rows, columns = interface.get_grid_size
    total_players.times { add_player }
    create_grid rows, columns
  end

  def players
    @players
  end

  def complete?
    @complete
  end

  def start!(options={})
    shuffle_players unless options[:no_shuffle]
    until complete?
      turn_for(current_player)
    end
  end

  def turn_for(player)
    puts grid if player.human?
    cell = player.choose_cell_from available_cells
    cell.value = player.symbol
    
    move_ended_game?(cell) ? end_game : move_player_to_end(player) 
  end

  def play!
    setup
    start!
  end

  private

  def interface
    @interface ||= TicTacToe::Interface::Game.new
  end

  def available_cells
    @grid.available_cells
  end

  def move_ended_game?(cell)
    if move_won_game? cell
      @complete_type = :win
    elsif no_cells_left?
      @complete_type = :tie
    else
      return false
    end 
    return true
  end

  def complete!
    @complete = true
    puts grid
  end

  def game_won_by(player)
    puts "#{player.symbol} won!"
    complete!
  end

  def game_tie
    complete!
    puts "It\'s a tie!"
  end

  def get_computer_symbol
    available_symbols.first
  end
  
  def symbols_in_use
    players.map(&:symbol)
  end

  def evaluator
    @evaluator ||= TicTacToe::Evaluator.new(@grid)
  end

  def current_player
    players_in_order.first
  end

  def shuffle_players
    players_in_order.shuffle!
  end

  def players_in_order
    @players_in_order ||= @players.dup
  end

  def end_game
    case @complete_type
    when :win
      game_won_by current_player
    when :tie
      game_tie
    else
      nil
    end
    self.class.new.play! if interface.play_again?
  end
  
  def move_player_to_end(player)
    players_in_order.push players_in_order.delete(player)
  end

  def move_won_game?(cell)
    evaluator.check_win_for cell
  end

  def no_cells_left?
    grid.available_cells.empty?
  end

end
