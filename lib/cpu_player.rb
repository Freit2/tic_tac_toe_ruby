require 'player'

class CpuPlayer < Player
  module Patterns
    Winning =
      [[(/ OO....../),0],[(/O..O.. ../),6],
       [(/......OO /),8],[(/.. ..O..O/),2],
       [(/ ..O..O../),0],[(/...... OO/),6],
       [(/..O..O.. /),8],[(/OO ....../),2],
       [(/ ...O...O/),0],[(/..O.O. ../),6],
       [(/O...O... /),8],[(/.. .O.O../),2],
       [(/O O....../),1],[(/O.. ..O../),3],
       [(/......O O/),7],[(/..O.. ..O/),5],
       [(/. ..O..O./),1],[(/... OO.../),3],
       [(/.O..O.. ./),7],[(/...OO .../),5]]
    Blocking =
      [[(/  X . X  /),1],[(/ XX....../),0],[(/X..X.. ../),6],
       [(/......XX /),8],[(/.. ..X..X/),2],[(/ ..X..X../),0],
       [(/...... XX/),6],[(/..X..X.. /),8],[(/XX ....../),2],
       [(/ ...X...X/),0],[(/..X.X. ../),6],[(/X...X... /),8],
       [(/.. .X.X../),2],[(/X X....../),1],[(/X.. ..X../),3],
       [(/......X X/),7],[(/..X.. ..X/),5],[(/. ..X..X./),1],
       [(/... XX.../),3],[(/.X..X.. ./),7],[(/...XX .../),5],
       [(/ X X.. ../),0],[(/ ..X.. X /),6],[(/.. ..X X /),8],
       [(/ X ..X.. /),2],[(/  XX.. ../),0],[(/X.. .. X /),6],
       [(/.. .XX   /),8],[(/X  ..X.. /),2],[(/ X  ..X../),0],
       [(/ ..X..  X/),6],[(/..X..  X /),8],[(/X  ..X.. /),2]]
  end

  attr_reader :type

  def initialize(piece)
    super(piece)
    @type = 'cpu'
  end

  def make_move(board)
    move_pos = get_winning_pattern_move(board)
    move_pos = get_blocking_pattern_move(board) if !move_pos
    move_pos = get_first_available_move(board) if !move_pos
    get_move_from_minmax
    move_pos
  end

  def get_move_from_minmax
  end

  def get_winning_pattern_move(board)
    move_pos = nil
    array = Patterns::Winning.find { |p| p.first =~ board.board.join }
    if array
      move_pos = array.last
    end
    move_pos
  end

  def get_blocking_pattern_move(board)
    move_pos = nil
    array = Patterns::Blocking.find { |p| p.first =~ board.board.join }
    if array
      move_pos = array.last
    end
    move_pos
  end

  def get_first_available_move(board)
    if !board.occupied?(4)
      move_pos = 4
    else
      move_pos = board.board.index(' ')
    end
    move_pos
  end
end
