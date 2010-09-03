require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'std_ui'

describe StdUI do
  before(:each) do
    File.delete("test.csv") if File.exists?("test.csv")
    @input = StringIO.new
    @output = StringIO.new
    @ui = StdUI.new(@input, @output)
  end

  after(:all) do
    File.delete("test.csv") if File.exists?("test.csv")
  end

  it "should get input from user" do
    @input.string == "hello world"
    @ui.user_input.should.to_s == "hello world"
  end
  
  it "should display message" do
    @ui.display_message('hello world')
    @ui.output.string.should == 'hello world'
  end

  it "should return board type from user" do
    @input.string = '3'
    @ui.board_type(['3x3']).should == '3'
  end

  it "should return player type from user" do
    @input.string = 'h'
    @ui.player_type('X').should == 'h'
  end

  it "should return a move for human player from user" do
    @input.string = '4'
    @ui.human_player_move('X').should == 4
  end

  it "should return an answer from user if user wants to play again" do
    @input.string = 'y'
    @ui.play_again.should == 'y'
  end

  it "should return board" do
    board = Board.new([].fill(0, 9) { @x })
    board_line = "\n---+---+---\n"
    message = "\n\n #{board[0..2].join(' | ')} " +
      "#{board_line} #{board[3..5].join(' | ')} " +
      "#{board_line} #{board[6..8].join(' | ')} \n\n"

    @ui.board_layout(board).should == message

    board_2 = Board.new([].fill(0, 16) { @x })
    board_line = "\n---+---+---+---\n"
    message = "\n\n #{board_2[0..3].join(' | ')} " +
      "#{board_line} #{board_2[4..7].join(' | ')} " +
      "#{board_line} #{board_2[8..11].join(' | ')} " +
      "#{board_line} #{board_2[12..15].join(' | ')} \n\n"

    @ui.board_layout(board_2).should == message
  end

  it "should display board" do
    board = mock("board")
    @ui.should_receive(:board_layout).and_return(board)
    @ui.should_receive(:display_message).with(board)
    @ui.display_board(board)
  end

  it "should display winner" do
    @ui.display_winner('X')
    @ui.output.string.should == "The winner is X."
  end

  it "should display scores" do
    scoreboard = Scoreboard.new("test.csv")
    scoreboard.scores = {:o => {:wins => 2, :losses => 1, :draws => 1},
                  :x => {:wins => 1, :losses => 2, :draws => 1}}

    @ui.display_scores(scoreboard)
    line =   "\n-----------------------------------\n"
    columns =  "          | wins | losses | draws |\n"
    player_o = "player O     2   |   1    |  1    |\n"
    player_x = "player X     1   |   2    |  1    |\n"
    @ui.output.string.should == "\n" + line + columns + player_o + player_x + line
  end
end
