require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'std_ui'
require 'stringio'

describe StdUI do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @ui = StdUI.new(@input, @output)
  end

  it "should get input from user" do
    @input.string == "hello world"
    @ui.get_input.should.to_s == "hello world"
  end
  
  it "should display message" do
    @ui.display_message('hello world')
    @ui.output.string.should == 'hello world'
  end

  it "should return player type from user" do
    @input.string = 'h'
    @ui.get_player_type('X').should == 'h'
  end

  it "should return a move for human player from user" do
    @input.string = '4'
    @ui.get_human_player_move('X').should == 4
  end

  it "should return an answer from user if user wants to play again" do
    @input.string = 'y'
    @ui.get_play_again.should == 'y'
  end

  it "should display board" do
    board = [].fill(0, 9) { @x }
    board_line = "\n---+---+---\n"
    message = "\n\n #{board[0..2].join(' | ')} " +
      "#{board_line} #{board[3..5].join(' | ')} " +
      "#{board_line} #{board[6..8].join(' | ')} \n\n"
    @ui.display_board(board)
    @ui.output.string.should == message
  end

  it "should display winner" do
    @ui.display_winner('X')
    @ui.output.string.should == "The winner is X."
  end
end
