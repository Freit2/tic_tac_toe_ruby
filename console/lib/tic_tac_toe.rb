require File.expand_path(File.dirname(__FILE__)) + "/init"
require 'std_ui'

class TicTacToe
  include TTT

  attr_reader :ui, :player_o, :player_x, :cache, :scoreboard
  attr_accessor :game, :board, :board_selection

  def initialize(ui = StdUI.new)
    @ui = ui
    @scoreboard = Scoreboard.new
    initialize_cache
  end

  def player(piece)
    player_type = ""
    loop do
      player_type = @ui.player_type(piece)
      break if player_type =~ /^h$|^e$|^m$|^u$/
    end
    return Player.create(player_type, piece)
  end

  def create_players
    @player_o = player('O')
    @player_x = player('X')
    @player_o.ui = @ui
    @player_x.ui = @ui
    cache = TTT::CONFIG.cache[TTT::CONFIG.boards[@board_selection][:cache]]
    @player_o.cache = cache
    @player_x.cache = cache
  end

  def board
    board_type = ""
    loop do
      board_type = @ui.board_type(TTT::CONFIG.boards.active)
      break if board_type =~ /^3$|^4$/
    end
    if board_type == '4'
      @board_selection = '4x4'
      return Board.new(nil, 16)
    else
      @board_selection = '3x3'
      return Board.new
    end
  end
  
  def play
    loop do
      @board = board
      create_players
      @game = Game.new(@player_o, @player_x, @board, @ui)
      @game.scoreboard = @scoreboard
      @game.play
      break if !play_again?
    end
    @ui.display_exit_message
  end

  def play_again?
    play_again = ''
    loop do
      play_again = @ui.play_again
      break if play_again =~ /^y$|^n$/
      @ui.display_try_again
    end
    return play_again == 'y' ? true : false
  end
end

if $0 == __FILE__
  ttt = TicTacToe.new
  if TTT::CONFIG.boards.active.size == 0
    puts "***Error***: No active boards found"
    exit
  end
  ttt.play
end
