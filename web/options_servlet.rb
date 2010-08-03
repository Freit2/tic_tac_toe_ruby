require 'webrick'
require 'erb'

class OptionsServlet < WEBrick::HTTPServlet::AbstractServlet
  
  def initialize(config, *options)
    puts "OptionsServlet initialize"
    super(config)
    @options = *options
  end

  def self.get_instance config, *options
    load __FILE__
    new config, *options
  end

  def do_GET(request, response)
    status, content_type, body = display_options(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def display_options(request)
    title = "WEBrick Tic Tac Toe!"
    template = ERB.new <<-EOS
    <head>
      <title><%= title %></title>
    </head>
    <body>
    <center>
    <h1 style="font-family:helvetica">Tic Tac Toe!</h1>
    <hr />
    <form method='POST' action='/new'>
    <p>
    Board Type
    <select name="board">
      <% TTT::CONFIG.boards.active.each do |board| %>
        <option><%= board %></option>
      <% end %>
    </select>
    </p>
    <p>
    Player O
    <select name="player_o">
      <% TTT::CONFIG.players.values.each do |value| %>
        <option><%= value[:value] %></option>
      <% end %>
    </select>
    </p>
    <p>
    Player X
    <select name="player_x">
      <% TTT::CONFIG.players.values.each do |value| %>
        <option><%= value[:value] %></option>
      <% end %>
    </select>
    </p>
    <p>
    <input type="submit" value="Start Game" />
    </p>
    </form>
    <h1>
    <p style="font-family:courier;font-size:50px">
     O | X | O  <br />
    ---+---+--- <br />
     X | O | X  <br />
    ---+---+--- <br />
     X | O | X  <br />
    </p>
    </h1>
    </center>
    </body>
    EOS
    return 200, "text/html", template.result(binding)
  end
end
