module Configuration
  Board3x3 = {:id => "3x3", :on => "3x3.jpg", :off => "3x3_dim.jpg"}
  Board4x4 = {:id => "4x4", :on => "4x4.jpg", :off => "4x4_dim.jpg"}
  Boards = []
  Boards << Board3x3
  Boards << Board4x4

  PlayerHuman = {:id => "human", :value => "human", :on => "player_human.jpg", :off => "player_human_dim.jpg"}
  PlayerCpuEasy = {:id => "easy", :value => "easy", :on => "player_easy_cpu.jpg", :off => "player_easy_cpu_dim.jpg"}
  PlayerCpuMedium = {:id => "med", :value => "med", :on => "player_med_cpu.jpg", :off => "player_med_cpu_dim.jpg"}
  PlayerCpuHard = {:id => "hard", :value => "unbeatable", :on => "player_hard_cpu.jpg", :off => "player_hard_cpu_dim.jpg"}

  Players = []
  Players << PlayerHuman << PlayerCpuEasy << PlayerCpuMedium << PlayerCpuHard
end