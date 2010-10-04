require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

describe TicTacToeEngine::Board do
  before(:each) do
    @board = TicTacToeEngine::Board.new
    @x = 'X'
    @o = 'O'
  end

  it "should set winning patterns" do
    @board.winning_patterns.size.should == 16
    board = TicTacToeEngine::Board.new(16)
    board.winning_patterns.size.should == 20
  end

  it "should return default size for board" do
    @board.size.should == 9
  end

  it "should return size for board" do
    board = TicTacToeEngine::Board.new(16)
    board.size.should == 16
  end

  it "should return row size for board" do
    @board.row_size.should == 3

    board_2 = TicTacToeEngine::Board.new(16)
    board_2.row_size.should == Math.sqrt(16).to_i
  end

  it "should return ranges for board" do
    @board.ranges.should == [(0...3), (3...6), (6...9)]
    
    board = TicTacToeEngine::Board.new(16)
    board.ranges.should == [(0...4), (4...8), (8...12), (12...16)]
  end

  it "should return board rows in array" do
    board = TicTacToeEngine::Board.from_moves([@x, @o, @x, @o, @x, @o, @o, @o, @x])
    board.rows.should == [[@x, @o, @x], [@o, @x, @o], [@o, @o, @x]]

    board_2 = TicTacToeEngine::Board.from_moves([@x, @o, @x, @o, @x, @o, @o, @x,
                         @x, @o, @x, @o, @x, @o, @o, @x])
    board_2.rows.should == [[@x, @o, @x, @o], [@x, @o, @o, @x],
                            [@x, @o, @x, @o], [@x, @o, @o, @x]]
  end

  it "should accept existing board array" do
    board = [@x, @o, @x, @o, @x, @o, @o, @o, @x]
    new_board = TicTacToeEngine::Board.from_moves(board)
    new_board.to_s.should == "XOXOXOOOX"
  end

  it "should occupy square if move is made" do
    @board.move(0, @x)
    @board.occupied?(0).should == true
  end

  it "should not occupy square if square is already occupied" do
    @board.move(0, @x)
    @board.move(0, @o)
    @board.piece_in(0).should == @x
  end

  it "should return true if game is over" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @x)
    @board.move(3, @o)
    @board.move(4, @o)
    @board.move(5, @x)
    @board.move(6, @x)
    @board.move(7, @x)
    @board.move(8, @o)
    @board.winner.should be_nil
    @board.game_over?.should == true
  end

  it "should return true if someone wins" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @board.winner.should == @x
    @board.win_moves.should == [0,1,2]
    @board.someone_win?.should == true
  end

  it "should return true for a valid move" do
    9.times do |s|
      @board.valid_move?(s).should == true
    end
  end

  it "should return pieces for specific squares" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.piece_in(0).should == @x
    @board.piece_in(1).should == @o
  end

  it "should return an array of empty squares" do
    @board.empty_squares.size.should == 9
    @board.move(0, @x)
    @board.empty_squares.size.should == 8
  end

  it "should return last move" do
    @board.move(0, @x)
    @board.last_move.should == 0
    @board.move(1, @o)
    @board.last_move.should == 1
    @board.move(0, @o)
    @board.last_move.should == 1
  end

  it "should have winning patterns with three elements" do
    @board.winning_patterns.each do |w|
      w.size.should == 3
      w[1].class.should == Array
      w[1].size.should == 3
    end
  end

  it "should clear move" do
    @board.move(0, @x)
    @board.clear(0)

    @board.to_s.should == "         "
  end

  it "should clear winner" do
    @board.winner = @o
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @board.clear(1)

    @board.winner.should == nil
  end

  it "parses a string representation of a 3x3 board" do
    @board.move(0, @o)
    @board.move(1, @x)
    @board.move(2, @o)
    string_value = @board.serialize

    new_board = TicTacToeEngine::Board.parse(string_value)
    new_board.move_list.should == [@o, @x, @o, ' ', ' ', ' ', ' ', ' ', ' ']
  end

  it "parses a string representation of a 4x4 board" do
    board = TicTacToeEngine::Board.new(16)
    board.move(0, @o)
    board.move(1, @x)
    board.move(2, @o)
    board.move(3, @o)
    board.move(4, @x)
    board.move(5, @o)
    string_value = board.serialize

    new_board = TicTacToeEngine::Board.parse(string_value)
    new_board.move_list.should == [@o, @x, @o, @o, @x, @o, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  it "returns moves made" do
    @board.move(0, @o)
    @board.move(1, @x)
    @board.move(2, @o)
    @board.moves_made.should == 3
  end
end
