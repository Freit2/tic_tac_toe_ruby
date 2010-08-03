require 'webrick'
require 'erb'

class Board < WEBrick::HTTPServlet::AbstractServlet
  def self.get_instance config, *options
    load __FILE__
    new config, *options
  end

  def do_POST(request, response)
    status, content_type, body = ttt(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def ttt(request)
    request.query.collect { |key, value| puts "#{key} : #{value}" }

    return 200, "text/plain", "New Game"
  end
end
