class Game
  attr_reader :player_o, :player_x, :board, :ui
  attr_accessor :scoreboard

  def initialize(player_o, player_x, board, ui)
    @board = board
    @ui = ui
    @player_o = player_o
    @player_x = player_x
    @player_o.board = @board
    @player_x.board = @board
  end

  def move_from(player)
    loop do
      move = player.make_move
      if @board.valid_move?(move)
        return move
      end
    end
  end

  def make_move(player)
    if !@board.game_over?
      @ui.current_player = player
      player_move = move_from(player)
      @board.move(player_move, player.piece)
      @ui.display_board(@board)
    end
  end

  def play
    @ui.display_board(@board)
    while !@board.game_over?
      switch_player
      make_move(@current_player)
    end
    end_of_play
  end

  def current_player
    if @current_player.nil?
      @current_player = @board.move_list.size.even? ? @player_o : @player_x
    end
    return @current_player
  end

  def switch_player
    @current_player = @current_player == @player_o ? @player_x : @player_o
    @ui.current_player = @current_player
  end

  def non_blocking_play
    while !@board.game_over?
      switch_player
      @ui.display_board(@board)
      if @current_player.is_a? HumanPlayer
        @ui.human_player_move(@current_player.piece)
        return
      else
        @board.move(move_from(@current_player), @current_player.piece)
      end
    end
    end_of_play
  end

  def end_of_play
    display_end_message
    @scoreboard.add_scores(@board.winner)
    @ui.display_scores(@scoreboard)
    @ui.display_try_again
  end

  def display_end_message
    if @board.winner
      @ui.display_winner(@board.winner)
    else
      @ui.display_draw_message
    end
  end
end
