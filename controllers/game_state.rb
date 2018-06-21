require_relative '../models/game_board'


class GameState
  attr_accessor :player, :game

  def initialize()
    @game = GameBoard.new
    @player = 1
  end

  def show_board
    # system "clear"

    if player == 1
      symbol = "@"
    else
      symbol = "O"
    end

    puts "Turn: Player #{player} - (#{symbol})"

    # Prints @game top to bottom
    r = 5
    while r >= 0
      print_row = ""
      game.board.each do |c|
        if c[r] == 1
          print_row << " (@) "
        elsif c[r] == 2
          print_row << " (O) "
        else
          print_row << " ( ) "
        end
      end
      puts print_row
      r -= 1
    end
    puts "  1    2    3    4    5    6    7\n"
  end

# Restarts game after a win
  def new_game
    @player = 1
    @game = GameBoard.new
    system "clear"
    show_board
    select_column
  end

# Switches player from 1 to 2 and back, called on successful select_column input
  def switch_player
    player == 1 ? @player = 2 : @player = 1
  end

# Method: Select column, accepts 1-7 input
  def select_column
    puts "Select a column to drop your piece. Press '9' to quit."

    selection = gets.to_i

    # Handles null input recorded as '0'
    if selection == 0
      puts "Pick a column between 1-7"
      select_column
    else
      selection -= 1
    end

    if selection < game.board.length
      # Successful selection, adds to @game, switches player
      if game.board[selection].length < 6
        # board is updated
        game.board[selection] << player
        # check board for a win
        if game.check_winner(game.board[selection].length - 1, selection, player)
          system "clear"
          show_board
          puts "Player ##{player} is the winner! Press `Enter` to restart."
          selection = gets.to_i
          new_game
        else
          # switch the player
          switch_player
          system "clear"
          # re-render board
          show_board
        end

      # Handles selecting a full column
      else
        puts "Column ##{selection + 1} is full, select another one."
        select_column
      end
    # Handles selecting an invalid column
    elsif selection == 8
      puts "Good-bye!"
      exit(0)
    else
      puts "Pick a column between 1-7"
      select_column
    end

    select_column
  end
end
