require 'yaml'
require 'digest'

module Control
  class Note
    TITLE = 'title'.freeze
    BODY = 'body'.freeze
    PASSWORD = 'password'.freeze
    ID = 'id'.freeze
    Note = Struct.new(:title, :body, :password)

    #todo: Implement here errors controls,
    #before sending data to service layer.

    def self.new_note(request)
      data = request.POST
      title = data[TITLE]
      body = data[BODY]
      password = data[PASSWORD]

      Note.new(title, body, password)
    end

    def self.retrieve_note(request)
      data = request.POST
      id = data[ID]
      password = Digest::MD5.digest(data[PASSWORD])

      note = YAML.load(File.read("#{id}.yml"))
      if note[PASSWORD] == password
        note
      else
        raise 'Access denied'
      end
    end
  end
end
