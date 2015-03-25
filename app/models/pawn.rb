class Pawn < Piece
  def legal_move?(x, y)
    return false if backwards_move?(y)

    unless capture_move?(x, y)
      return false if horizontal_move?(x)
    end

    proper_length?(y)
  end

  def obstructed_move?(x, y)
    # check if a white 2 square move with obstruction
    return true if y_position == 1 && y == 3 && game.obstruction(x, 2)
    # check if a black 2 square move with obstruction
    return true if y_position == 6 && y == 4 && game.obstruction(x, 5)
    return false
  end

  private

  def horizontal_move?(x)
    x_diff = (x_position - x).abs
    x_diff != 0
  end

  def backwards_move?(y)
    color ? y_position > y : y_position < y   
  end

  def first_move?(y)
    (y_position == 1 && color) || (y_position == 6 && !color)
  end

  def proper_length?(y)
    y_diff = (y - y_position).abs
    first_move?(y) ? (y_diff == 1 || y_diff == 2) : y_diff == 1
  end

  def capture_move?(x, y)
    x_diff = (x_position - x).abs
    y_diff = (y_position - y).abs
    game.obstruction(x, y) ? (x_diff == 1) && (y_diff == 1) : false
  end


end