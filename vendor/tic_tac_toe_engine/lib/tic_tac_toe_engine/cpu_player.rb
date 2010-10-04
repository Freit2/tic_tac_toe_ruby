module TicTacToeEngine
  class CpuPlayer < Player
    attr_reader :winning_patterns, :blocking_patterns

    def initialize(piece)
      super(piece)
    end

    def make_move
      @ui.display_cpu_move_message(@piece)
      move_pos = winning_pattern_move
      move_pos = blocking_pattern_move if !move_pos
      move_pos = first_available_move if !move_pos
      return rand(@board.size) if rand(3) == 0
      return move_pos
    end

    def winning_pattern_move
      initialize_patterns(@piece) if !@winning_patterns
      move_pos = nil
      array = @winning_patterns.find { |p| p.first =~ @board.to_s }
      if array
        move_pos = array.last
      end
      return move_pos
    end

    def blocking_pattern_move
      initialize_patterns(@piece) if !@blocking_patterns
      move_pos = nil
      array = @blocking_patterns.find { |p| p.first =~ @board.to_s }
      if array
        move_pos = array.last
      end
      return move_pos
    end

    def first_available_move
      if !@board.occupied?(4)
        move_pos = 4
      else
        move_pos = @board.index(' ')
      end
      return move_pos
    end

    private
    def initialize_patterns(p)
      case @board.size
      when 9
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
      when 16
        @winning_patterns =
          [[(/ #{p}#{p}#{p}............/),0],
           [(/#{p} #{p}#{p}............/),1],
           [(/#{p}#{p} #{p}............/),2],
           [(/#{p}#{p}#{p} ............/),3],
           [(/.... #{p}#{p}#{p}......../),4],
           [(/....#{p} #{p}#{p}......../),5],
           [(/....#{p}#{p} #{p}......../),6],
           [(/....#{p}#{p}#{p} ......../),7],
           [(/........ #{p}#{p}#{p}..../),8],
           [(/........#{p} #{p}#{p}..../),9],
           [(/........#{p}#{p} #{p}..../),10],
           [(/........#{p}#{p}#{p} ..../),11],
           [(/............ #{p}#{p}#{p}/),12],
           [(/............#{p} #{p}#{p}/),13],
           [(/............#{p}#{p} #{p}/),14],
           [(/............#{p}#{p}#{p} /),15],
           [(/ ...#{p}...#{p}...#{p}.../),0],
           [(/#{p}... ...#{p}...#{p}.../),4],
           [(/#{p}...#{p}... ...#{p}.../),8],
           [(/#{p}...#{p}...#{p}... .../),12],
           [(/. ...#{p}...#{p}...#{p}../),1],
           [(/.#{p}... ...#{p}...#{p}../),5],
           [(/.#{p}...#{p}... ...#{p}../),9],
           [(/.#{p}...#{p}...#{p}... ../),13],
           [(/.. ...#{p}...#{p}...#{p}./),2],
           [(/..#{p}... ...#{p}...#{p}./),6],
           [(/..#{p}...#{p}... ...#{p}./),10],
           [(/..#{p}...#{p}...#{p}... ./),14],
           [(/... ...#{p}...#{p}...#{p}/),3],
           [(/...#{p}... ...#{p}...#{p}/),7],
           [(/...#{p}...#{p}... ...#{p}/),11],
           [(/...#{p}...#{p}...#{p}... /),15],
           [(/ ....#{p}....#{p}....#{p}/),0],
           [(/#{p}.... ....#{p}....#{p}/),5],
           [(/#{p}....#{p}.... ....#{p}/),10],
           [(/#{p}....#{p}....#{p}.... /),15],
           [(/... ..#{p}..#{p}..#{p}.../),3],
           [(/...#{p}.. ..#{p}..#{p}.../),6],
           [(/...#{p}..#{p}.. ..#{p}.../),9],
           [(/...#{p}..#{p}..#{p}.. .../),12]]
        p = (p == 'O') ? 'X' : 'O'
        @blocking_patterns =
          [[(/ #{p}#{p}#{p}............/),0],
           [(/#{p} #{p}#{p}............/),1],
           [(/#{p}#{p} #{p}............/),2],
           [(/#{p}#{p}#{p} ............/),3],
           [(/.... #{p}#{p}#{p}......../),4],
           [(/....#{p} #{p}#{p}......../),5],
           [(/....#{p}#{p} #{p}......../),6],
           [(/....#{p}#{p}#{p} ......../),7],
           [(/........ #{p}#{p}#{p}..../),8],
           [(/........#{p} #{p}#{p}..../),9],
           [(/........#{p}#{p} #{p}..../),10],
           [(/........#{p}#{p}#{p} ..../),11],
           [(/............ #{p}#{p}#{p}/),12],
           [(/............#{p} #{p}#{p}/),13],
           [(/............#{p}#{p} #{p}/),14],
           [(/............#{p}#{p}#{p} /),15],
           [(/ ...#{p}...#{p}...#{p}.../),0],
           [(/#{p}... ...#{p}...#{p}.../),4],
           [(/#{p}...#{p}... ...#{p}.../),8],
           [(/#{p}...#{p}...#{p}... .../),12],
           [(/. ...#{p}...#{p}...#{p}../),1],
           [(/.#{p}... ...#{p}...#{p}../),5],
           [(/.#{p}...#{p}... ...#{p}../),9],
           [(/.#{p}...#{p}...#{p}... ../),13],
           [(/.. ...#{p}...#{p}...#{p}./),2],
           [(/..#{p}... ...#{p}...#{p}./),6],
           [(/..#{p}...#{p}... ...#{p}./),10],
           [(/..#{p}...#{p}...#{p}... ./),14],
           [(/... ...#{p}...#{p}...#{p}/),3],
           [(/...#{p}... ...#{p}...#{p}/),7],
           [(/...#{p}...#{p}... ...#{p}/),11],
           [(/...#{p}...#{p}...#{p}... /),15],
           [(/ ....#{p}....#{p}....#{p}/),0],
           [(/#{p}.... ....#{p}....#{p}/),5],
           [(/#{p}....#{p}.... ....#{p}/),10],
           [(/#{p}....#{p}....#{p}.... /),15],
           [(/... ..#{p}..#{p}..#{p}.../),3],
           [(/...#{p}.. ..#{p}..#{p}.../),6],
           [(/...#{p}..#{p}.. ..#{p}.../),9],
           [(/...#{p}..#{p}..#{p}.. .../),12]]
      end
    end
  end
end