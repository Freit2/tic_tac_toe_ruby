# move positions
#
#  0 | 1 | 2
# ---+---+---
#  3 | 4 | 5
# ---+---+---
#  6 | 7 | 8

require File.expand_path(File.dirname(__FILE__)) + "/init" 
require 'game'
require 'board'
require 'human_player'
require 'cpu_player'

class TicTacToe
  attr_reader :input, :output, :player1, :player2, :game, :board
  def initialize(input, output)
    @input = input
    @output = output
  end

  def ask_for_player(piece)
    player_type = ""
    loop do
      @output.print "\nChoose player type for '#{piece}' ('h' for human or 'c' for cpu) "
      player_type = @input.gets.chomp
      break if player_type == "h" || player_type == "c"
    end
    if player_type == 'h'
      HumanPlayer.new(piece, @input, @output)
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
      @board = Board.new(@output)
      @game = Game.new(player1, player2, @board)
      @output.print @game.play
      play_again = ''
      loop do
        @output.print "\nDo you want to play again? ('y' or 'n') "
        play_again = @input.gets.chomp
        break if play_again == 'y' || play_again == 'n'
      end
      break if play_again == 'n'
    end
    @output.print "\nThanks for playing!"
  end
end

if $0 == __FILE__
  TicTacToe.new(STDIN, STDOUT).play
end
