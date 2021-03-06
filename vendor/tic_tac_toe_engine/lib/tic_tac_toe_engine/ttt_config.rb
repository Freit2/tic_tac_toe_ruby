TicTacToeEngine::TTT::CONFIG.boards = {
  :'3x3' => { :active => true, :cache => :hash, :on => "3x3.jpg", :off => "3x3_dim.jpg" },
  :'4x4' => { :active => true, :cache => :mongo, :on => "4x4.jpg", :off => "4x4_dim.jpg" }
}

# TicTacToeEngine::TTT::CONFIG.boards[:'3x3'][:active] = false
# TicTacToeEngine::TTT::CONFIG.boards[:'4x4'][:active] = false

TicTacToeEngine::TTT::CONFIG.pieces = {
  :o => 'O',
  :x => 'X'
}

TicTacToeEngine::TTT::CONFIG.players = {
  :human => { :value => "human",       :on => "player_human.jpg",    :off => "player_human_dim.jpg" },
  :easy  => { :value => "easy",        :on => "player_easy_cpu.jpg", :off => "player_easy_cpu_dim.jpg"},
  :med   => { :value => "med",         :on => "player_med_cpu.jpg",  :off => "player_med_cpu_dim.jpg"},
  :hard  => { :value => "unbeatable" , :on => "player_hard_cpu.jpg", :off => "player_hard_cpu_dim.jpg"}
}

TicTacToeEngine::TTT::CONFIG.cache = {}
