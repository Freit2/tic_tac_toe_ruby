require File.expand_path(File.dirname(__FILE__)) + "/init"
require 'webrick_server'
require 'board_servlet'

class WEBrickTTT < WEBrickServer
  include TTT

  attr_reader :document_root, :rhtml_path,
              :board_selection, :player_selection_o, :player_selection_x

  def initialize(port=10000+rand(10000))
    @port = port
    @document_root = "#{File.dirname(__FILE__)}/www/"
    @rhtml_path = "#{File.dirname(__FILE__)}/rhtml/"
    super
    @board_selection = TTT::CONFIG.boards.active.first
    @player_selection_o = TTT::CONFIG.players[TTT::CONFIG.players.keys.first][:value]
    @player_selection_x = TTT::CONFIG.players[TTT::CONFIG.players.keys.last][:value]
    initialize_cache
    mount("/new", BoardServlet, TTT::CONFIG.cache)
  end

  def start
    generate_index
    super
  end

  def options_for_board
    options = ""
    TTT::CONFIG.boards.active.each do |board|
      if board == @board_selection
        options += "<option selected=\"selected\">#{board}</option>"
      else
        options += "<option>#{board}</option>"
      end
    end
    return options
  end

  def options_for_player(default_selection)
    options = ""
    TTT::CONFIG.players.values.each do |hash|
      if hash[:value] == default_selection
        options += "<option selected=\"selected\">#{hash[:value]}</option>"
      else
        options += "<option>#{hash[:value]}</option>"
      end
    end
    return options
  end

  def generate_index
    File.delete("#{@document_root}index.html") if File.exists?("#{@document_root}index.html")
    data = open("#{@rhtml_path}index.rhtml") { |io| io.read }
    file = File.new("#{@document_root}index.html", "w")
    file.puts ERB.new(data).result(binding)
    file.close
  end
end

if $0 == __FILE__ then
  WEBrickTTT.new(7546).start
end
