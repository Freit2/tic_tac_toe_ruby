require File.expand_path(File.dirname(__FILE__)) + "/init" 
require 'game'
require 'board'
require 'ui'
require 'human_player'
require 'cpu_player'
require 'min_max_player'

class TicTacToe
  attr_reader :input, :output, :player1, :player2, :game, :board

  def initialize(input, output)
    @input = input
    @output = output
    @ui = UI.new(@input, @output)
  end

  def ask_for_player(piece)
    player_type = ""
    loop do
      player_type = @ui.get_player_type(piece)
      break if player_type == "h" ||
        player_type == "c" ||
        player_type == "m"
    end
    case player_type
    when 'h'
      return HumanPlayer.new(piece)
    when 'c'
      return CpuPlayer.new(piece)
    when 'm'
      return MinMaxPlayer.new(piece)
    end
  end

  def choose_players
    @player1 = ask_for_player('O')
    @player2 = ask_for_player('X')
    @player1.ui = @ui
    @player2.ui = @ui
  end
  
  def play
    loop do
      choose_players
      @board = Board.new
      @game = Game.new(player1, player2, @board, @ui)
      @game.play
      play_again = ''
      loop do
        play_again = @ui.get_play_again
        break if play_again == 'y' || play_again == 'n'
      end
      break if play_again == 'n'
    end
    @ui.display_exit_message
  end
end

if $0 == __FILE__
  TicTacToe.new(STDIN, STDOUT).play
end
