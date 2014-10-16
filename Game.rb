# encoding: UTF-8
require_relative 'Board.rb'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @player_color = true
  end
  
  def play
    
    puts "Welcome to chess! Please enter moves in the form of: e1e3"
    until check_mate?
      @board.display
      puts "White move:"
      move = get_valid_move
      @board.make_move(move[0], move[1])
      system "clear" or system "cls"
      @board.display
      
      if check_mate?
        puts "Congratulations White, you win!"
        return
      end
     
      puts "Black move:"
      @player_color = !@player_color
      move = get_valid_move
      @board.make_move(move[0], move[1])
      system "clear" or system "cls"
    end
  
    @board.display
    puts "Congratulations Black, you win!"
    
  end
  
  def check_mate?
    @board.check_mate?(true) || @board.check_mate?(false)
  end
  
  def get_valid_move
    letters = %w(a b c d e f g h)
    input = gets.chomp.split("")
  
    start = [letters.index(input[0]), input[1].to_i]
    dest = [letters.index(input[2]), input[3].to_i]
    piece = @board[start]
      
    moves = piece.moves
    if !moves.include?(dest) || piece.moved_into_check?(start, dest) || @player_color != piece.color
      puts "not a valid move"
      get_valid_move
      return
    elsif attempting_to_castle?(piece, dest) #castling
      if dest[0] > piece.pos[0]
        unless king_side_castle?(piece)
          puts "not a valid move"
          get_valid_move
          return
        end
      else
        unless queen_side_castle?(piece)
          puts "not a valid move"
          get_valid_move
          return
        end
      end
    end
    [piece, dest]
  end
  
  def attempting_to_castle?(piece, dest)
    piece.is_a?(King) && (piece.pos[0] - dest[0]).abs == 2
  end
  
  
  
  def king_side_castle?(piece)
    pos1 =[piece.pos[0] + 1, piece.pos[1]]
    b = @board.dup
    b.make_move(b[piece.pos], pos1)
    return false if b.check?(piece.color)
    true
  end
  
  def queen_side_castle?(piece)
    pos2 = [piece.pos[0] - 1, piece.pos[1]]
    b = @board.dup
    b.make_move(b[piece.pos], pos2)
    return false if b.check?(piece.color)
    true
  end
      
end


g = Game.new
g.play


