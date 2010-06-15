require 'player'

class HumanPlayer < Player
  attr_reader :type, :input, :output

  def initialize(piece, input, output)
    super(piece)
    @input = input
    @output = output
  end

  def make_move()
    @output.print "\nEnter your move, player '#{@piece}' [0-8]: "
    return @input.gets.to_i
  end
end
