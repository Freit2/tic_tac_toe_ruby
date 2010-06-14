# game_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'human_player'
require 'cpu_player'
require 'game'

describe Game do
  before(:each) do
    @std_in = StringIO.new
    @std_out = StringIO.new
    @player1 = HumanPlayer.new('O', @std_in, @std_out)
    @player2 = CpuPlayer.new('X')
    @game = Game.new(@player1, @player2, @std_out)
  end

  it "should hold two different players" do
    @game.player1.should be(@player1)
    @game.player2.should be(@player2)
  end

  it "should hold a board instance" do
    @game.board.instance_of?(Board) == true
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

  it "should allow only nine turns" do
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

    @game.board.should_receive(:display).twice
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

  it "should display winner via std_out" do
    @player1.should_receive(:piece).exactly(3).times.and_return('X')
    @player2.should_receive(:piece).exactly(2).times.and_return('O')
    @player1.should_receive(:make_move).and_return(0)
    @player2.should_receive(:make_move).and_return(3)
    @player1.should_receive(:make_move).and_return(1)
    @player2.should_receive(:make_move).and_return(4)
    @player1.should_receive(:make_move).and_return(2)

    @game.std_out.should_receive(:puts).with("The winner is X.")
    @game.play
  end
end
