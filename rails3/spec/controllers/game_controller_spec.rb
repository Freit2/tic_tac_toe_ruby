require 'spec_helper'

describe GameController do
  before(:all) do
    @params = {:board => '3x3',
               :player_o => 'human',
               :player_x => 'unbeatable'}
    @get_params = {:s => 0}
  end

  it "starts new game" do
    TicTacToe.should_receive(:start).and_return(ttt = mock("ttt"))
    ttt.should_receive(:board).and_return(board = mock("board"))
    board.should_receive(:serialize).and_return(" , , , , , , , , ")
    ttt.should_receive(:request).exactly(3).times.and_return(request = mock("request"))
    request.should_receive(:[]).exactly(3).times.and_return("")

    post :start, @params
  end

  it "resumes game" do
    TicTacToe.should_receive(:resume).and_return(ttt = mock("ttt"))
    ttt.should_receive(:board).and_return(board = mock("board"))
    board.should_receive(:serialize).and_return(" , , , , , , , , ")
    ttt.should_receive(:request).exactly(3).times.and_return(request = mock("request"))
    request.should_receive(:[]).exactly(3).times.and_return("")

    get :start, @get_params
  end
end
