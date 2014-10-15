# encoding: UTF-8
# require 'SlidingPiece.rb'
class Rook < SlidingPiece
  def initialize(pos, color, board)
    if color
      @symbol = "♖"
    else
      @symbol = "♜"
    end
    super
  end
  
  def moves
    # moves returns [rows, cols, diags]
    super[0] + super[1]
  end
end