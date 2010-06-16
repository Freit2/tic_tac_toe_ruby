require 'player'

class CpuPlayer < Player
  attr_reader :winning_patterns, :blocking_patterns
   
  def initialize(piece)
    super(piece)
    set_patterns(piece)
  end

  def make_move()
    @ui.display_message("Player '#{@piece}' makes a move")
    move_pos = get_winning_pattern_move
    move_pos = get_blocking_pattern_move if !move_pos
    move_pos = get_first_available_move if !move_pos
    return move_pos
  end

  def get_winning_pattern_move
    move_pos = nil
    array = @winning_patterns.find { |p| p.first =~ @board.to_s }
    if array
      move_pos = array.last
    end
    return move_pos
  end

  def get_blocking_pattern_move
    move_pos = nil
    array = @blocking_patterns.find { |p| p.first =~ @board.to_s }
    if array
      move_pos = array.last
    end
    return move_pos
  end

  def get_first_available_move
    if !@board.occupied?(4)
      move_pos = 4
    else
      move_pos = @board.index(' ')
    end
    return move_pos
  end

  private
  def set_patterns(p)
    @winning_patterns =
      [[(/ #{p}#{p}....../),0],[(/#{p}..#{p}.. ../),6],
       [(/......#{p}#{p} /),8],[(/.. ..#{p}..#{p}/),2],
       [(/ ..#{p}..#{p}../),0],[(/...... #{p}#{p}/),6],
       [(/..#{p}..#{p}.. /),8],[(/#{p}#{p} ....../),2],
       [(/ ...#{p}...#{p}/),0],[(/..#{p}.#{p}. ../),6],
       [(/#{p}...#{p}... /),8],[(/.. .#{p}.#{p}../),2],
       [(/#{p} #{p}....../),1],[(/#{p}.. ..#{p}../),3],
       [(/......#{p} #{p}/),7],[(/..#{p}.. ..#{p}/),5],
       [(/. ..#{p}..#{p}./),1],[(/... #{p}#{p}.../),3],
       [(/.#{p}..#{p}.. ./),7],[(/...#{p}#{p} .../),5]]
    o = (p == 'O') ? 'X' : 'O'
    @blocking_patterns =
      [[(/  #{o} . #{o}  /),1],[(/ #{o}#{o}....../),0],[(/#{o}..#{o}.. ../),6],
       [(/......#{o}#{o} /),8],[(/.. ..#{o}..#{o}/),2],[(/ ..#{o}..#{o}../),0],
       [(/...... #{o}#{o}/),6],[(/..#{o}..#{o}.. /),8],[(/#{o}#{o} ....../),2],
       [(/ ...#{o}...#{o}/),0],[(/..#{o}.#{o}. ../),6],[(/#{o}...#{o}... /),8],
       [(/.. .#{o}.#{o}../),2],[(/#{o} #{o}....../),1],[(/#{o}.. ..#{o}../),3],
       [(/......#{o} #{o}/),7],[(/..#{o}.. ..#{o}/),5],[(/. ..#{o}..#{o}./),1],
       [(/... #{o}#{o}.../),3],[(/.#{o}..#{o}.. ./),7],[(/...#{o}#{o} .../),5],
       [(/ #{o} #{o}.. ../),0],[(/ ..#{o}.. #{o} /),6],[(/.. ..#{o} #{o} /),8],
       [(/ #{o} ..#{o}.. /),2],[(/  #{o}#{o}.. ../),0],[(/#{o}.. .. #{o} /),6],
       [(/.. .#{o}#{o}   /),8],[(/#{o}  ..#{o}.. /),2],[(/ #{o}  ..#{o}../),0],
       [(/ ..#{o}..  #{o}/),6],[(/..#{o}..  #{o} /),8],[(/#{o}  ..#{o}.. /),2]]
  end
end
