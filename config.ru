require 'rack'
require_relative 'router.rb'

class Note
  def self.call(env)
    request = Rack::Request.new(env)

    body, status, headers = Router::Controller.give_response(request)

    response = Rack::Response.new(body, status, headers)
    response.finish
  end
end

run Note
