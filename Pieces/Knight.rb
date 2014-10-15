# encoding: UTF-8
require_relative 'SteppingPiece.rb'

class Knight < SteppingPiece
  OFFSETS = [
    [1, 2],
    [1, -2],
    [-1, -2],
    [-1, 2],
    [2, 1],
    [2, -1],
    [-2, -1],
    [-2, 1]
  ]
  
  def initialize(pos, color, board)
    if color
      @symbol = "♘"
    else
      @symbol = "♞"
    end
    super
  end
end