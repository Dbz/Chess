# require 'Piece.rb'
class SteppingPiece < Piece
  def initialize(pos, color, board)
    super
  end
  
  def moves
    
    valid_steps = []
    start_x, start_y = @pos[0], @pos[1]
    self.class::OFFSETS.each do |x, y|
      if in_bounds?([x + start_x, y + start_y])
        valid_steps << [x + start_x, y + start_y]
      end
    end

    valid_pos(valid_steps)
  end
  
  def valid_pos(arr)
    arr.select { |p| @board[p].nil? || @board[p].color != @color }
  end
end