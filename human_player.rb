require 'player'

class HumanPlayer < Player
  attr_reader :type, :std_in, :std_out

  def initialize(piece, std_in, std_out)
    super(piece)
    @type = 'human'
    @std_in = std_in
    @std_out = std_out
  end

  def make_move(*args)
    @std_out.print "\nEnter your move, player '#{@piece}' [0-8]: "
    @std_in.gets.to_i
  end
end
