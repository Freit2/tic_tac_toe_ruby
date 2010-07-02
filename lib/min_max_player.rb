require File.expand_path(File.dirname(__FILE__)) + "/init" 
require 'player'
require 'board'

class MinMaxPlayer < Player

  def initialize(piece)
    super(piece)
  end

  def make_move
    @ui.display_cpu_move_message(@piece)
    if @board.get_empty_squares.size == @board.size
      return rand(@board.size)
    end
    get_best_move(@board, @piece, 1)
    moves = get_mirrored_moves
    puts moves.inspect
    return moves[rand(moves.size)]
    #return @best_move
  end

  def get_opponent(piece)
    return piece === 'O' ? 'X' : 'O'
  end

  def evaluate_score(board, piece, depth)
    opponent = get_opponent(piece)
    case board.winner
    when piece
      return (depth == 2) ? 2 : 1
    when opponent
      return (depth == 2) ? -2 : -1
    else
      return 0
    end
  end

  def get_best_move(board, piece, depth)
    if board.game_over?
      return evaluate_score(board, piece, depth)
    else
      best_score = -999
      opponent = get_opponent(piece)
      empty_squares = board.get_empty_squares
      empty_squares.each do |s|
        temp_board = Board.new(board.to_a)
        temp_board.move(s, piece)
        score = -get_best_move(temp_board, opponent, depth + 1)
        if depth == 1
          puts "move: #{s}, score: #{score}"
        end
        if score > best_score
          best_score = score
          @best_move = s if depth == 1
        end
      end
      return best_score
    end
  end

  def get_mirrored_moves
    mirrored_moves = []
    board_template = []; (0...@board.size).each { |s| board_template << s }
    array_template = board_template.dup
    array = @board.to_a.dup
    3.times do
      array_template = [array_template[0..2].reverse, array_template[3..5].reverse,
                        array_template[6..8].reverse].transpose.flatten
      array = [array[0..2].reverse, array[3..5].reverse,
               array[6..8].reverse].transpose.flatten
      if @board.to_a == array
        mirrored_moves << array_template[@best_move]
      end
    end

    return mirrored_moves << @best_move
  end
end

if $0 == __FILE__
  require 'rubygems'
  require 'jruby-prof'
  require 'std_ui'

  result = JRubyProf.profile do
    min_max_player = MinMaxPlayer.new('O')
    min_max_player.board = Board.new
    min_max_player.ui = StdUI.new
    puts min_max_player.make_move
  end

  JRubyProf.print_flat_text(result, "flat.txt")
  JRubyProf.print_graph_text(result, "graph.txt")
  JRubyProf.print_graph_html(result, "graph.html")
  JRubyProf.print_call_tree(result, "call_tree.txt")
  JRubyProf.print_tree_html(result, "call_tree.html")
end