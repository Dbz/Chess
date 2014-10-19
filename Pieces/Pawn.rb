# encoding: UTF-8
require_relative './Piece.rb'
class Pawn < Piece
  def initialize(pos, color, board)
    @starting_pos = pos.dup
    @has_moved = false
    if color
      @symbol = "♙"
    else
      @symbol = "♟"
    end
    super
  end
  
  def pos=(value)
    @pos = pos
    if color
      promote_pawn if value[0] == 7
    else
      promote_pawn if value[0] == 0
    end
  end
  
  def promote_pawn
  end
        
  
  def moves
    total_moves = []
    x, y = @pos[0], @pos[1]
    
    #Staring Move
    if @starting_pos == @pos && in_bounds?([x, y + 2]) && color && @board[[x, y + 2]].nil?
      total_moves << [x, y + 2]
    end
    if @starting_pos == @pos && in_bounds?([x, y - 2]) && !color && @board[[x, y - 2]].nil?
      total_moves << [x, y - 2]
    end
    # Attack
    if in_bounds?([x+1, y+1]) && @board.enemy_piece?([x+1, y+1], !@color) && color
      total_moves << [x+1, y+1]
    end
    
    if in_bounds?([x-1, y-1]) && @board.enemy_piece?([x-1, y-1], !@color) && !color
      total_moves << [x-1, y-1]
    end
    
    
    if in_bounds?([x-1, y+1]) && @board.enemy_piece?([x-1, y+1], !@color) && color
      total_moves << [x-1, y+1] 
    end
    
    if in_bounds?([x+1, y-1]) && @board.enemy_piece?([x+1, y-1], !@color) && !color
      total_moves << [x+1, y-1] 
    end
    # Forward
   if in_bounds?([x, y+1]) && @board[[x, y+1]].nil? && color
     total_moves << [x, y+1]
   end
   
   if in_bounds?([x, y-1]) && @board[[x, y-1]].nil? && !color
     total_moves << [x, y-1]
   end
    
    total_moves
  end
  
  
end