require 'rack'
require_relative 'router.rb'

class Note
  def self.call(env)
    request = Rack::Request.new(env)

    response =
      begin
        body, status, headers = Router::Controller.give_response(request)
        Rack::Response.new(body, status, headers)
      rescue ArgumentError, RangeError => error
        error_body, error_status, error_headers = Router::Controller.error_response(error.class)
        Rack::Response.new(error_body, error_status, error_headers)
      end

    response.finish
  end
end

run Note
