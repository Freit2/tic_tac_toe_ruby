require File.expand_path(File.dirname(__FILE__)) + "/init" 
require 'game'
require 'board'
require 'std_ui'
require 'player'

class TicTacToe
  attr_reader :ui, :player_o, :player_x, :game, :board

  def initialize(ui = StdUI.new)
    @ui = ui
  end

  def ask_for_player(piece)
    player_type = ""
    loop do
      player_type = @ui.get_player_type(piece)
      break if player_type =~ /^h$|^e$|^m$|^u$/
    end
    return Player.create(player_type, piece)
  end

  def choose_players
    @player_o = ask_for_player('O')
    @player_x = ask_for_player('X')
    @player_o.ui = @ui
    @player_x.ui = @ui
  end
  
  def play
    loop do
      choose_players
      @board = Board.new
      @game = Game.new(@player_o, @player_x, @board, @ui)
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
  TicTacToe.new.play
end
