require File.expand_path(File.dirname(__FILE__)) + "/init" 
require 'game'
require 'board'
require 'std_ui'
require 'player'

class TicTacToe
  attr_reader :ui, :player_o, :player_x
  attr_accessor :game, :board

  def initialize(ui = StdUI.new)
    @ui = ui
  end

  def get_player(piece)
    player_type = ""
    loop do
      player_type = @ui.get_player_type(piece)
      break if player_type =~ /^h$|^e$|^m$|^u$/
    end
    return Player.create(player_type, piece)
  end

  def create_players
    @player_o = get_player('O')
    @player_x = get_player('X')
    @player_o.ui = @ui
    @player_x.ui = @ui
  end

  def get_board
    board_type = ""
    loop do
      board_type = @ui.get_board_type
      break if board_type =~ /^3$|^4$/
    end
    return board_type == '4' ? Board.new(nil, 16) : Board.new
  end
  
  def play
    loop do
      @board = get_board
      create_players
      @game = Game.new(@player_o, @player_x, @board, @ui)
      @game.play
      break if !play_again?
    end
    @ui.display_exit_message
  end

  def play_again?
    play_again = ''
    loop do
      play_again = @ui.get_play_again
      break if play_again =~ /^y$|^n$/
    end
    return play_again == 'y' ? true : false
  end
end

if $0 == __FILE__
  TicTacToe.new.play
end
