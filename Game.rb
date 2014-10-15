# encoding: UTF-8
require 'debugger'
require_relative 'Board.rb'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
  end
  
  def play
    
    puts "Welcome to chess: enter standard-ish moves, e.g. e1e3"
    until check_mate?
      @board.display
      puts "White please move:"
      move = get_valid_move
      @board.make_move(move[0], move[1])
      system "clear"
      @board.display
      
     if check_mate?
       puts "Congratulations White, you win!"
       return
     end
     
      puts "Black please move:"
      move = get_valid_move
      @board.make_move(move[0], move[1])
      system "clear"
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
      if !moves.include?(dest) || piece.moved_into_check?(start, dest)
        puts " not a valid move"
        get_valid_move
      else
        [piece, dest]
      end
  end
      
end


g = Game.new
g.play


