# encoding: UTF-8
require_relative './Pieces/Piece.rb'
require_relative './Pieces/SlidingPiece.rb'
require_relative './Pieces/SteppingPiece.rb'
require_relative './Pieces/Pawn.rb'
require_relative './Pieces/Queen.rb'
require_relative './Pieces/Rook.rb'
require_relative './Pieces/Knight.rb'
require_relative './Pieces/Bishop.rb'
require_relative './Pieces/King.rb'

require 'colorize'

class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil } }
    populate
  end
  
  def populate
    set_pawns
    set_rooks
    set_knights
    set_bishops
    set_queens
    set_kings
  end
  
  def display
    letters = %w(a b c d e f g h)
    string = "   0  1  2  3  4  5  6  7    \n"
    @grid.each_with_index do |row, idx1|
      string += letters[idx1] + " "
      row.each_with_index do |piece, idx2|
        unless piece.nil?
          string += (" " + piece.to_s + " ").colorize(:background => color(idx1, idx2))
        else
          string += "   ".colorize(:background => color(idx1, idx2))
        end
      end
      string += "\n"
    end
    
    puts string
  end
  
  def color(idx1, idx2)
    if (idx1.even? && idx2.even?) || (idx1.odd? && idx2.odd?)
      :brown
    else
      :white
    end
  end
  
  
  def dup
    b = Board.new
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        unless piece.nil?
          b[[i,j]] = piece.dup_piece(b)
        else
          b[[i,j]] = nil
        end
      end
    end
    b
  end
  
  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  
  def []=(pos, value)
    @grid[pos[0]][pos[1]]=value
  end
  
  def check?(color)
    king_pos = find_king_pos(color)
    
    @grid.each do |row|
      row.each do |piece|
        next if piece.nil? || piece.color == color
        return true if piece.moves.include? king_pos
      end
    end
    false
  end
  
  def find_king_pos(color)
    @grid.each do |row|
      row.each do |piece|
        next if piece.nil? || piece.color != color
        if piece.class == King
          return piece.pos
        end
      end
    end
  end
  
  def check_mate?(color)
    return false unless self.check?(color)
    pieces = pieces(color)
    
    pieces.each do |piece|
      moves = piece.moves
      moves.each do |dest|
        b = self.dup
        p = b[piece.pos]
        b.make_move([p, dest])
        unless b.check?(color)
          return false
        end
      end
    end
    true
  end
  
  def enemy_piece?(pos, color)
    return false if self[pos].nil? 
    self[pos].color == color
  end
  
  def make_move(piece, dest)
    if piece.is_a?(King) && (piece.pos[0] - dest[0]).abs == 2 # Castling
      if dest[0] < piece.pos[0]
        rook = self[[0, piece.pos[1]]]
        new_pos = [piece.pos[0] - 1, piece.pos[1]]
        make_move(rook, new_pos)
      else
        rook = self[[7, piece.pos[1]]]
        new_pos = [piece.pos[0] + 1, piece.pos[1]]
        make_move(rook, new_pos)
      end
    end
    
    self[piece.pos] = nil
    self[dest] = piece
    piece.pos = dest
  end
  
  private
  
  def pieces(color)
    @grid.flatten.compact.select {|piece| piece.color == color }
  end
  
  def set_pawns
    (0..7).each do |i|
      @grid[i][1] = Pawn.new([i, 1], true, self)
      @grid[i][6] = Pawn.new([i, 6], false, self)
    end
  end
  
  def set_rooks
    self[[0,0]] = Rook.new([0,0], true, self)
    self[[7,0]] = Rook.new([7,0], true, self)
    self[[0,7]] = Rook.new([0,7], false, self)
    self[[7,7]] = Rook.new([7,7], false, self)
  end
  
  def set_knights
    self[[1,0]] = Knight.new([1,0], true, self)
    self[[6,0]] = Knight.new([6,0], true, self)
    self[[1,7]] = Knight.new([1,7], false, self)
    self[[6,7]] = Knight.new([6,7], false, self)
  end
  
  def set_bishops
    self[[2,0]] = Bishop.new([2,0], true, self)
    self[[5,0]] = Bishop.new([5,0], true, self)
    self[[2,7]] = Bishop.new([2,7], false, self)
    self[[5,7]] = Bishop.new([5,7], false, self)
  end
  
  def set_queens
    self[[3,0]] = Queen.new([3,0], true, self)
    self[[3,7]] = Queen.new([3,7], false, self)
  end
  
  def set_kings
    self[[4,0]] = King.new([4,0], true, self)
    self[[4,7]] = King.new([4,7], false, self)
  end
end

