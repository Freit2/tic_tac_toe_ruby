# move positions
#
#  0 | 1 | 2
# ---+---+---
#  3 | 4 | 5
# ---+---+---
#  6 | 7 | 8

require 'game'
require 'board'
require 'human_player'
require 'cpu_player'

class TicTacToe
  attr_reader :std_in, :std_out, :player1, :player2, :game, :board
  def initialize(*args)
    @std_in = STDIN
    @std_out = STDOUT
    @std_in = args[0] if args.size > 0
    @std_out = args[1] if args.size > 0
  end

  def ask_for_player(piece)
    player_type = ""
    loop do
      @std_out.print "\nChoose player type for '#{piece}' ('h' for human or 'c' for cpu) "
      player_type = @std_in.gets.chomp
      break if player_type == "h" || player_type == "c"
    end
    if player_type == 'h'
      HumanPlayer.new(piece, @std_in, @std_out)
    else
      CpuPlayer.new(piece)
    end
  end

  def choose_players
    @player1 = ask_for_player('O')
    @player2 = ask_for_player('X')
  end
  
  def play
    loop do
      choose_players
      @board = Board.new(@std_out)
      @game = Game.new(player1, player2, @board)
      @std_out.print @game.play
      play_again = ''
      loop do
        @std_out.print "\nDo you want to play again? ('y' or 'n') "
        play_again = @std_in.gets.chomp
        break if play_again == 'y' || play_again == 'n'
      end
      break if play_again == 'n'
    end
    @std_out.print "\nThanks for playing!"
  end
end

if $0 == __FILE__
  TicTacToe.new.play
end
