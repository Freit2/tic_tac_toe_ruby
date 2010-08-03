Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }
require 'webrick'
require 'erb'

class Options < WEBrick::HTTPServlet::AbstractServlet
  def self.get_instance config, *options
    load __FILE__
    new config, *options
  end

  def do_GET(request, response)
    status, content_type, body = options(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def options(request)
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
      <option>3x3</option>
      <option>4x4</option>
    </select>
    </p>
    <p>
    Player O
    <select name="player_o">
      <option>human</option>
      <option>easy cpu</option>
      <option>medium cpu</option>
      <option>unbeatable cpu</option>
    </select>
    </p>
    <p>
    Player X
    <select name="player_x">
      <option>human</option>
      <option>easy cpu</option>
      <option>medium cpu</option>
      <option>unbeatable cpu</option>
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
