# encoding: UTF-8
require_relative 'Piece.rb'


class King < SteppingPiece
  OFFSETS = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0],
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]
  
  def initialize(pos, color, board)
    if color
      @symbol = "♔"
    else
      @symbol = "♚"
    end
    super
  end
  
end