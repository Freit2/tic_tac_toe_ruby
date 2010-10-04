require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'std_ui'

describe TicTacToeEngine::Player do

  context "creating players for a name and piece" do
    it "gives you human player for 'H'" do
      player = TicTacToeEngine::Player.create('H', 'O')
      player.class.should == TicTacToeEngine::HumanPlayer
      player.piece.should == 'O'
    end

    it "gives you easy cpu player for 'E'" do
      player = TicTacToeEngine::Player.create('E', 'O')
      player.class.should == TicTacToeEngine::EasyCpuPlayer
      player.piece.should == 'O'
    end

    it "gives you medium cpu player for 'M'" do
      player = TicTacToeEngine::Player.create('M', 'X')
      player.class.should == TicTacToeEngine::CpuPlayer
      player.piece.should == 'X'
    end

      it "gives you medium cpu player for 'U'" do
      player = TicTacToeEngine::Player.create('U', 'X')
      player.class.should == TicTacToeEngine::NegamaxPlayer
      player.piece.should == 'X'
    end
  end
  
  it "returns O for piece when creating player" do
    player = TicTacToeEngine::Player.new('O')
    player.piece.should == 'O'
  end

  it "should allow board to be set" do
    board = TicTacToeEngine::Board.new
    player = TicTacToeEngine::Player.new('X')
    player.board = board
    player.board.should equal(board)
  end

  it "should allow ui to be set" do
    ui = StdUI.new(STDIN, STDOUT)
    player = TicTacToeEngine::Player.new('X')
    player.ui = ui
    player.ui.should == ui
  end  
end


