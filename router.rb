require_relative 'services/notes.rb'
require_relative 'views/welcome.rb'
require_relative 'views/creation.rb'
require_relative 'views/retrieval.rb'
require_relative 'views/creation_success.rb'
require_relative 'views/retrieval_success.rb'
require_relative 'views/error.rb'

module Router
  class Controller
    HTML_HEADER = { 'Content-Type' => 'text/html' }

    module Path
      HOME = '/'.freeze
      CREATION = '/creation'.freeze
      RETRIEVAL = '/retrieval'.freeze
      CREATION_SUCCESS = '/creation_success'.freeze
      RETRIEVAL_SUCCESS = '/retrieval_success'.freeze
    end

    module Method
      POST = 'POST'.freeze
      GET = 'GET'.freeze
    end

    def self.give_response(request)
      body = select_body(request)
      #status = select_status(request)
      status = 200
      headers = HTML_HEADER
      [body, status, headers]
    end

    def self.select_body(request)
      if get(request, Path::HOME)
        View::Welcome.show

      elsif get(request, Path::CREATION)
        View::Creation.show

      elsif get(request, Path::RETRIEVAL)
        View::Retrieval.show

      elsif post(request, Path::CREATION)
        id = Service::Note.save(request)
        #View::Blank.show
        View::CreationSuccess.show(id)

      elsif post(request, Path::RETRIEVAL)
        note = Service::Note.retrieve_note(request)
        #View::Blank.show
        View::RetrievalSuccess.show(note.title, note.body)

      #PATTERN POST-GET HAVE TO BE IMPLEMENTED:

      #elsif get(request, Path::CREATION_SUCCESS)
      #  id = Service::Note.give_id(request)
      #  View::Creation_success.show(id)

      #elsif get(request, Path::RETRIEVAL_SUCCESS)
      #  note = Service::Note.retrieve_note(request)
      #  View::Retrieval_success.show(note.title, note.body)

      else
        View::Error.show

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
