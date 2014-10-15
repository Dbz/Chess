# require_relative 'Piece.rb'
class SlidingPiece < Piece
  
  def initialize(pos, color, board)
    super    
  end
  
  def moves
    x , y = @pos[0], @pos[1]
    
    columns = (0...8).map {|n| [n, y] }
    rows = (0...8).map {|n| [x, n] }
    
    diagonal1 = []
    diagonal2 = []
    
    (-7...8).each do |n|
      diagonal1 << [x + n, y + n]
      diagonal2 << [x + n, y - n]
    end
    
    diagonal1.select! { |pos| in_bounds? pos }
    diagonal2.select! { |pos| in_bounds? pos }
    
    [
      valid_pos(rows), 
      valid_pos(columns), 
      valid_pos(diagonal1) + valid_pos(diagonal2)
    ]
  end
  
  def valid_pos(arr)
    valid_slides = []
    
    starting_pos = arr.index(@pos)
    
    arr[starting_pos + 1 .. -1].each do |p|
      if @board[p].nil?
        valid_slides << p
      elsif @board[p].color != @color
        valid_slides << p
        break
      else
        break
      end
    end
    
    arr[0...starting_pos].reverse.each do |p|
      if @board[p].nil?
        valid_slides << p
      elsif @board[p].color != @color
        valid_slides << p
        break 
      else
        break 
      end
    end
    
    valid_slides
  end
  
  
  
end