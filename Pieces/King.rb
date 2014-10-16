# encoding: UTF-8
require_relative 'SteppingPiece.rb'

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
  attr_accessor :has_moved
  def initialize(pos, color, board)
    @has_moved = false
    if color
      @symbol = "♔"
    else
      @symbol = "♚"
    end
    super
  end
  
  def pos=(value)
    @pos = value
    @has_moved = true
  end
  
  def moves
    #Adding castling 
    positions = super
    unless @has_moved
      rook1 = @board[[@pos[0] - 4, @pos[1]]]
      rook2 = @board[[@pos[0] + 3, @pos[1]]]
      if rook1.is_a?(Rook) && !rook1.has_moved
        if clear_path_1? 
          positions << [@pos[0] - 2, @pos[1]]
        end
      end
      
      if rook2.is_a?(Rook) && !rook2.has_moved
        if clear_path_2?
          positions << [pos[0] + 2, @pos[1]]
        end
      end
    end
    positions
  end
  
  def clear_path_1?
    @board[[@pos[0] - 1, @pos[1]]].nil? &&
    @board[[@pos[0] - 2, @pos[1]]].nil? &&
    @board[[@pos[0] - 3, @pos[1]]].nil?
  end
  
  def clear_path_2?
    @board[[@pos[0] + 1, @pos[1]]].nil? &&
    @board[[@pos[0] + 2, @pos[1]]].nil?
  end
    
end