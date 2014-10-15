# encoding: UTF-8
# require 'SlidingPiece.rb'
class Queen < SlidingPiece
  def initialize(pos, color, board)
    if color
      @symbol = "♕"
    else
      @symbol = "♛"
    end
    super
  end
  
  def moves
    new_moves = []
    # moves returns [rows, cols, diags]
    super.each do |arr|
      new_moves += arr
    end
    new_moves
  end
  
end