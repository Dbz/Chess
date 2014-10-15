# encoding: UTF-8
# require 'SlidingPiece.rb'
class Rook < SlidingPiece
  attr_accessor :has_moved
  def initialize(pos, color, board)
    @had_moved = false
    if color
      @symbol = "♖"
    else
      @symbol = "♜"
    end
    super
  end
  
  def pos=(value)
    @pos = value
    @has_moved = true
  end
  
  def moves
    # moves returns [rows, cols, diags]
    super[0] + super[1]
  end
end