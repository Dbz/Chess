# encoding: UTF-8
require_relative './Piece.rb'
require_relative './Queen.rb'
require_relative './Rook.rb'
require_relative './Knight.rb'
require_relative './Bishop.rb'

require 'byebug'

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
    @pos = value
    if @color
      promote_pawn if @pos[1] == 7
    else
      promote_pawn if @pos[1] == 0
    end
  end
  
  # TODO: change unless / end to begin / rescue / end
  def promote_pawn
    return if @board.is_duplicate?
    options = ["queen", "knight", "rook", "bishop"]
    puts "Please select the piece that you would like to promote the pawn to!"
    puts options.map(&:capitalize).join(", ")
    
    input = gets.chomp.downcase
    unless options.include? input
      puts "That wasn't an option. Please try again!"
      promote_pawn
    end
    
    @board[@pos] = nil
    case input
    when "queen"
      @board[@pos] = Queen.new(@pos, color, @board)
    when "knight"
      @board[@pos] = Knight.new(@pos, color, @board)
    when "rook"
      @board[@pos] = Rook.new(@pos, color, @board)
    when "bishop"
      @board[@pos] = Bishop.new(@pos, color, @board)
    end
  end
        
  
  def moves
    total_moves = []
    x, y = @pos[0], @pos[1]
    
    #Staring Move
    if @starting_pos == @pos && in_bounds?([x, y + 2]) && color && @board[[x, y + 2]].nil?
      total_moves << [x, y + 2]
    elsif @starting_pos == @pos && in_bounds?([x, y - 2]) && !color && @board[[x, y - 2]].nil?
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
    elsif in_bounds?([x, y-1]) && @board[[x, y-1]].nil? && !color
      total_moves << [x, y-1]
    end
    
    # En Passant
    last_move = @board.last_move
    if last_move
      last_move_piece = @board[last_move.dest].class.name
      #debugger
      # White on 5th rank, last move was made by a pawn from 7th rank to 5th rank and position is now next to pawn
      if @color && y == 4 && last_move_piece == "Pawn" && last_move.pos[1] == 6 && last_move.dest[1] == 4 && x + 1 == last_move.pos[0]
        total_moves << [x+1, y+1]
      elsif @color && y == 4 && last_move_piece == "Pawn" && last_move.pos[1] == 6 && last_move.dest[1] == 4 && x - 1 == last_move.pos[0]
        total_moves << [x-1, y+1]
      # Black on 3rd rank, last move was made by a pawn from 2nd rank to 4th rank and position is now next to pawn
      elsif !@color && y == 3 && last_move_piece == "Pawn" && last_move.pos[1] == 1 && last_move.dest[1] == 3 && x + 1 == last_move.pos[0]
        total_moves << [x+1, y-1]
      elsif !@color && y == 3 && last_move_piece == "Pawn" && last_move.pos[1] == 1 && last_move.dest[1] == 3 && x - 1 == last_move.pos[0]
        total_moves << [x-1, y-1]
      end
    end
    
    total_moves
  end
  
  
  
end