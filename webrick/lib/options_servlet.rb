require 'webrick'
require 'erb'

class OptionsServlet < WEBrick::HTTPServlet::AbstractServlet
  attr_reader :options
  attr_accessor :board_selection, :player_selection_o, :player_selection_x

  @@instance = nil
  @@instance_creation_mutex = Mutex.new

  def self.get_instance config, *options
    @@instance_creation_mutex.synchronize {
      @@instance = @@instance || self.new(config, *options)
    }
  end

  def initialize(config, *options)
    puts "OptionsServlet initialize"
    super(config)
    @options = *options
    @template = "options_template.rhtml"
    
    @board_selection = TTT::CONFIG.boards.active.first
    @player_selection_o = TTT::CONFIG.players[TTT::CONFIG.players.keys.first][:value]
    @player_selection_x = TTT::CONFIG.players[TTT::CONFIG.players.keys.last][:value]
  end

  def do_GET(request, response)
    puts "OptionsServlet do_GET"
    status, content_type, body = display_options(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  alias :do_POST :do_GET

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
    template = convert(@template)
    return 200, "text/html", template.result(binding)
  end
end
