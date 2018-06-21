class GameBoard
  attr_reader :board

  def initialize()
    @board = Array.new(7) { Array.new(0) }
  end

  def check_winner(row, column, player)
    # create arrays for both diagonal directions
    diag_arr_a = create_diag(row, column, 'up')
    diag_arr_b = create_diag(row, column, 'down')
    # create array for horizontal row
    row_arr = create_row(row)
    # check horizontal, vertical, and diagonal arrays for 4-in-a-row, return true if there's a win
    if check_four(self.board[column], player) || check_four(row_arr, player) || check_four(diag_arr_a, player) || check_four(diag_arr_b, player)
      true
    end
  end

  # Checks array for 4 in a row of a value matching the active player
  def check_four(arr, player)
    count = 1
    arr.each_with_index { |v,i|
      if count == 4
        true
      elsif v == player && arr[i + 1] == player
        count += 1
      end
    }
    count >= 4
  end

  # Create array for vertial row
  def create_row(r)
    row  = Array.new
    self.board.each { |a|
      row << a[r]
    }
    row
  end

  def create_diag(r, c, dir)
    diag = Array.new
    if dir == 'up'
      while r > 0 && c > 0
        r -= 1
        c -= 1
      end
      while r < 5 && c < 6
        diag << self.board[c][r]
        r += 1
        c += 1
      end
    else
      while r < 5 && c > 0
        r += 1
        c -= 1
      end
      while r >= 0 && c < 6
        diag << self.board[c][r]
        r -= 1
        c += 1
      end
    end
    diag
  end
end
