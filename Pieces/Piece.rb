class Piece
  attr_accessor :pos, :color
  
  def initialize(pos, color, board)
    @board = board
    @pos = pos
    @color = color    
  end
  
  def in_bounds?(position)
    x, y = position[0], position[1]
    x >= 0 && x < 8 &&
    y >= 0 && y < 8
  end
  
  def to_s
    @symbol
  end
  
  def dup_piece(new_board)
   self.class.new(@pos.dup, @color, new_board)
  end
  
  def moved_into_check?(start, dest)
    b = @board.dup
    b.make_move(b[start], dest)
    b.check? b[dest].color
  end
end