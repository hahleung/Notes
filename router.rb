require_relative 'services/notes.rb'
require_relative 'views/welcome.rb'
require_relative 'views/creation.rb'

module Router
  class Controller
    HTML_HEADER = { 'Content-Type' => 'text/html' }

    module Path
      HOME = '/'.freeze
      CREATION = '/creation'.freeze
      RETRIEVAL = '/retrieval'.freeze
    end

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
      if get(request, Path::HOME)
        View::Welcome.show

      elsif get(request, PATH::CREATION)
        View::Creation.show

      elsif get(request, PATH::RETRIEVAL)

      elsif post(request, Path::CREATION)
        Service::Note.save(request)

      end
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
      request.path == path && request.request_method == method
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
