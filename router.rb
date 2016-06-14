require 'yaml'
require_relative 'services/notes.rb'
require_relative 'control/notes.rb'
require_relative 'storage/main_store.rb'
require_relative 'views/welcome.rb'
require_relative 'views/creation.rb'
require_relative 'views/retrieval.rb'
require_relative 'views/creation_success.rb'
require_relative 'views/retrieval_success.rb'
require_relative 'views/about.rb'
require_relative 'views/tutorial.rb'
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
      ABOUT = '/about'.freeze
      TUTORIAL = '/tutorial'.freeze
    end

    module Method
      POST = 'POST'.freeze
      GET = 'GET'.freeze
    end

    def self.give_response(request)
      body = select_body(request)
      status = 200
      headers = HTML_HEADER
      [body, status, headers]
    end

    def self.error_response(error_class)
      messages = YAML.load(File.read('error_messages.yml'))
      message = messages.values_at(error_class).shift

      body = View::Error.show(message)
      status = 404
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
        note = Control::Note.new_note(request)
        id, note = Service::Note.save(note)
        Storage::MainStore.new(Storage::FileStore).save(id, note)
        View::CreationSuccess.show(id)

      elsif post(request, Path::RETRIEVAL)
        id, password = Control::Note.retrieve_note(request)
        p id
        p password
        file = Storage::MainStore.new(Storage::FileStore).read(id, password)
        p 'here file'
        p file
        note = Service::Note.retrieve(file)
        p note
        View::RetrievalSuccess.show(note.title, note.body)

      elsif get(request, Path::ABOUT)
        View::About.show

      elsif get(request, Path::TUTORIAL)
        View::Tutorial.show

      else
        View::Error.show('Are you lost?')

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
