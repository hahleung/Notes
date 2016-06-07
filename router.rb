require_relative 'services/note.rb'

module Router
  class Controller
    HTML_HEADER = { 'Content-Type' => 'text/html' }

    module Method
      POST = 'POST'.freeze
      GET = 'GET'.freeze
    end

    def self.give_response(request)
      body = select_body(request)
      status = select_status(request)
      headers = HTML_HEADER
      [body, status, headers]
    end

def self.select_body(request)

end

    def self.select_status(request)
      method = request.request_method
      if method == Method::POST
        302
      else
        200
      end
    end

    def self.match_route?(request, path, method)
      request.path == path && request.request_method == current_method
    end

    def self.get(request, path)
      match_route?(request, path, Method::GET)
    end

    def self.post(request, path)
      match_route?(request, path, Method::POST)
    end

    private_class_method :method, :match_route?, :get, :post
  end
end
