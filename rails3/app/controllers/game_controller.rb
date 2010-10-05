class GameController < ApplicationController
  def start
    if params[:s]
      @ttt = TicTacToe.resume params, cookies
    else
      @ttt = TicTacToe.start params
    end

    cookies[:board_state] = @ttt.board.serialize.gsub(/\s/, '-')
    cookies[:board] = @ttt.request[:board]
    cookies[:player_o] = @ttt.request[:player_o]
    cookies[:player_x] = @ttt.request[:player_x]
  end
end
