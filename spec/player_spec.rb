require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'player'
require 'board'
require 'std_ui'

describe Player do

  context "creating players for a name and piece" do
    it "gives you human player for 'H'" do
      player = Player.create('H', 'O')
      player.class.should == HumanPlayer
      player.piece.should == 'O'
    end

    it "gives you easy cpu player for 'E'" do
      player = Player.create('E', 'O')
      player.class.should == EasyCpuPlayer
      player.piece.should == 'O'
    end

    it "gives you medium cpu player for 'M'" do
      player = Player.create('M', 'X')
      player.class.should == CpuPlayer
      player.piece.should == 'X'
    end

      it "gives you medium cpu player for 'U'" do
      player = Player.create('U', 'X')
      player.class.should == MinMaxPlayer
      player.piece.should == 'X'
    end
  end
  
  it "returns O for piece when creating player" do
    player = Player.new('O')
    player.piece.should == 'O'
  end

  it "should allow board to be set" do
    board = Board.new
    player = Player.new('X')
    player.board = board
    player.board.should == board
  end

  it "should allow ui to be set" do
    ui = StdUI.new(STDIN, STDOUT)
    player = Player.new('X')
    player.ui = ui
    player.ui.should == ui
  end  
end


