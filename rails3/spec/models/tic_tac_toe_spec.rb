require 'spec_helper'

describe TicTacToe do
  before(:each) do
    @ttt = TicTacToe.new
    @ttt.request = {:board => '3x3',
                    :player_o => 'human',
                    :player_x => 'unbeatable'}
  end

  it "initializes cache" do
    TicTacToe.new

    TicTacToeEngine::TTT::CONFIG.cache.length.should > 0
  end

  it "creates a board" do
    @ttt.create_board

    @ttt.board.class.should == TicTacToeEngine::Board
    @ttt.board.size.should == 9
  end

  it "creates players" do
    @ttt.create_players
    @ttt.player_x.class.should == TicTacToeEngine::NegamaxPlayer
    @ttt.player_o.class.should == TicTacToeEngine::HumanPlayer
  end

  it "assigns piece to players" do
    @ttt.create_players
    @ttt.player_x.piece.should == TicTacToeEngine::TTT::CONFIG[:pieces][:x]
    @ttt.player_o.piece.should == TicTacToeEngine::TTT::CONFIG[:pieces][:o]
  end

  it "adds UI to players" do
    @ttt.create_players
    @ttt.player_x.ui.class.should == TicTacToe
    @ttt.player_o.ui.class.should == TicTacToe
  end

  it "adds cache to players" do
    @ttt.create_players
    @ttt.player_x.cache.class.should == TicTacToeEngine::HashCache
    @ttt.player_o.cache.class.should == TicTacToeEngine::HashCache
  end

  it "creates game" do
    TicTacToeEngine::Game.should_receive(:new).and_return(@ttt.game = mock("game"))
    @ttt.game.should_receive(:scoreboard=)
    @ttt.game.should_receive(:non_blocking_play)
    @ttt.start_game
  end

  it "has game components" do
    @ttt.create_board
    @ttt.create_players
    @ttt.start_game
    @ttt.game.player_x.should be(@ttt.player_x)
    @ttt.game.player_o.should be(@ttt.player_o)
    @ttt.game.board.should be(@ttt.board)
  end

  it "resumes game, and makes move" do
    params = {:s => 0}
    cookies = {:board => '3x3',
               :player_o => 'human',
               :player_x => 'unbeatable',
               :board_state => " - - - - - - - - "}

    TicTacToeEngine::Board.should_receive(:parse).and_return(board = mock("board"))
    TicTacToe.should_receive(:new).and_return(ttt = mock("ttt"))
    ttt.should_receive(:request=).with({:board => '3x3',
                                        :player_o => 'human',
                                        :player_x => 'unbeatable'})
    ttt.should_receive(:board=).with(board)
    ttt.stub!(:board).and_return(mock("board"))
    ttt.board.stub!(:game_over?).and_return(false)
    ttt.stub!(:create_players)
    ttt.stub!(:start_game)
    ttt.board.stub!(:valid_move?).with(0).and_return(true)
    ttt.board.stub!(:move)
    ttt.stub!(:game).and_return(mock("game"))
    ttt.game.stub!(:non_blocking_play)
    ttt.game.stub!(:current_player).and_return(mock("current_player"))
    ttt.game.current_player.stub!(:piece)

    TicTacToe.resume(params, cookies).should == ttt
  end

  it "resumes game, but does not make move" do
    params = {:s => 0}
    cookies = {:board => '3x3',
               :player_o => 'human',
               :player_x => 'unbeatable',
               :board_state => " - - - - - - - - "}

    TicTacToeEngine::Board.should_receive(:parse).and_return(board = mock("board"))
    TicTacToe.should_receive(:new).and_return(ttt = mock("ttt"))
    ttt.should_receive(:request=).with({:board => '3x3',
                                        :player_o => 'human',
                                        :player_x => 'unbeatable'})
    ttt.should_receive(:board=).with(board)
    ttt.should_receive(:board).twice.and_return(mock("board"))
    ttt.board.should_receive(:game_over?).and_return(true)
    ttt.should_not_receive(:create_players)
    ttt.should_not_receive(:start_game)

    TicTacToe.resume(params, cookies).should == ttt
  end

  it "starts new game" do
    params = {:board => '3x3',
              :player_o => 'human',
              :player_x => 'unbeatable'}
    TicTacToe.should_receive(:new).and_return(ttt = mock("ttt"))

    ttt.should_receive(:request=).with(params)
    ttt.should_receive(:create_board)
    ttt.should_receive(:create_players)
    ttt.should_receive(:start_game)
    TicTacToe.start(params).should == ttt
  end

  it "responds to UI messages" do
    @ttt.respond_to?(:display_message).should be_true
    @ttt.respond_to?(:display_board).should be_true
    @ttt.respond_to?(:human_player_move).should be_true
    @ttt.respond_to?(:display_cpu_move_message).should be_true
    @ttt.respond_to?(:display_winner).should be_true
    @ttt.respond_to?(:display_draw_message).should be_true
    @ttt.respond_to?(:display_scores).should be_true
    @ttt.respond_to?(:display_try_again).should be_true
  end

  it "displays message" do
    status = mock("status")
    @ttt.display_message(status)
    @ttt.status.should == status
  end

  it "displays human move message" do
    piece = "X"
    @ttt.should_receive(:display_message).with("/images/messages/move_player_#{piece.downcase}.png")
    @ttt.human_player_move(piece)
  end

  it "displays winner" do
    winner = "X"
    @ttt.should_receive(:display_message).with("/images/end_message/winner_#{winner.downcase}.png")
    @ttt.display_winner(winner)
  end

  it "displays draw" do
    @ttt.should_receive(:display_message).with("/images/end_message/draw_game.png")
    @ttt.display_draw_message
  end
end
