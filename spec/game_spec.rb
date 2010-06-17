# game_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'game'
require 'human_player'
require 'cpu_player'
require 'board'
require 'ui'

describe Game do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @board = Board.new
    @ui = UI.new(@input, @output)
    @player1 = HumanPlayer.new('O')
    @player2 = CpuPlayer.new('X')
    @player1.ui = @ui
    @player2.ui = @ui
    @game = Game.new(@player1, @player2, @board, @ui)
  end

  it "should hold two different players" do
    @game.player1.should be(@player1)
    @game.player2.should be(@player2)
  end

  it "should hold a board" do
    @game.board.should be(@board)
  end

  it "should hold a ui" do
    @game.ui.should be(@ui)
  end

  it "should return a move for human player" do
    @ui.input.string = '1'
    @game.get_move_from(@player1).should == 1
  end

  it "should return a move from cpu player" do
    @game.get_move_from(@player2).should == 4
  end

  it "should play one turn" do
    @player1.should_receive(:make_move).and_return(0)
    @player1.should_receive(:piece).and_return('X')
    @player2.should_receive(:make_move).and_return(1)
    @player2.should_receive(:piece).and_return('X')

    @game.play_turn
  end
  
  it 'continues to ask a player for a valid move' do
    @player1.should_receive(:make_move).twice.and_return(-1)
    @player1.should_receive(:make_move).once.and_return(0)
    @game.get_move_from(@player1).should == 0
  end

  it 'places pieces on board for players' do
    @player1.should_receive(:make_move).and_return(0)
    @player1.should_receive(:piece).and_return('X')
    @player2.should_receive(:make_move).and_return(1)
    @player2.should_receive(:piece).and_return('O')

    @game.play_turn
    @game.board.occupied?(0).should == true
    @game.board.piece_in(0).should == 'X'
    @game.board.occupied?(1).should == true
    @game.board.piece_in(1).should == 'O'
  end

  it "should allow up to nine turns" do
    @player1.should_receive(:piece).exactly(5).times.and_return('X')
    @player2.should_receive(:piece).exactly(4).times.and_return('O')
    @player1.should_receive(:make_move).and_return(0)
    @player1.should_receive(:make_move).and_return(2)
    @player1.should_receive(:make_move).and_return(3)
    @player1.should_receive(:make_move).and_return(5)
    @player1.should_receive(:make_move).and_return(7)
    @player2.should_receive(:make_move).and_return(1)
    @player2.should_receive(:make_move).and_return(4)
    @player2.should_receive(:make_move).and_return(6)
    @player2.should_receive(:make_move).and_return(8)

    @game.play
  end

  it "should stop playing after someone wins" do
    @player1.should_receive(:piece).exactly(3).times.and_return('X')
    @player2.should_receive(:piece).exactly(2).times.and_return('O')
    @player1.should_receive(:make_move).and_return(0)
    @player2.should_receive(:make_move).and_return(3)
    @player1.should_receive(:make_move).and_return(1)
    @player2.should_receive(:make_move).and_return(4)
    @player1.should_receive(:make_move).and_return(2)

    @game.play
  end

  it "should display board after one turn" do
    @player1.should_receive(:piece).exactly(1).times.and_return('X')
    @player2.should_receive(:piece).exactly(1).times.and_return('O')
    @player1.should_receive(:make_move).and_return(0)
    @player2.should_receive(:make_move).and_return(1)

    @game.ui.should_receive(:display_board).twice
    @game.play_turn
  end

  it "should display winner when game ends" do
    @player1.should_receive(:piece).exactly(3).times.and_return('X')
    @player2.should_receive(:piece).exactly(2).times.and_return('O')
    @player1.should_receive(:make_move).and_return(0)
    @player2.should_receive(:make_move).and_return(3)
    @player1.should_receive(:make_move).and_return(1)
    @player2.should_receive(:make_move).and_return(4)
    @player1.should_receive(:make_move).and_return(2)

    @game.should_receive(:display_end_message)
    @game.play
  end
end
