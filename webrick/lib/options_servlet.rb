require 'webrick'
require 'erb'

class OptionsServlet < WEBrick::HTTPServlet::AbstractServlet
  attr_reader :options
  attr_accessor :board_selection, :player_selection_o, :player_selection_x

  @@instance = nil
  def self.get_instance config, *options
    #load __FILE__
    #new config, *options
    @@instance = @@instance || self.new(config, *options)
  end

  def initialize(config, *options)
    super(config)
    @options = *options
    @board_selection = TTT::CONFIG.boards.active.first
    @player_selection_o = TTT::CONFIG.players[TTT::CONFIG.players.keys.first][:value]
    @player_selection_x = TTT::CONFIG.players[TTT::CONFIG.players.keys.last][:value]
  end

  def do_GET(request, response)
    status, content_type, body = display_options(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
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
    TTT::CONFIG.players.values.each do |value|
      if value[:value] == default_selection
        options += "<option selected=\"selected\">#{value[:value]}</option>"
      else
        options += "<option>#{value[:value]}</option>"
      end
    end
    return options
  end

  def convert(rhtml_file)
    return ERB.new IO.read(File.expand_path(File.dirname(__FILE__)) + "/rhtml/#{rhtml_file}")
  end

  def display_options(request)
    title = "WEBrick Tic Tac Toe!"
    template = convert("options_template.rhtml")
    return 200, "text/html", template.result(binding)
  end
end
