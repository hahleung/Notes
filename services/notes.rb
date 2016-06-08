require 'yaml'
require_relative '../models/notes.rb'
require_relative '../control/notes.rb'

module Service
  Retrieved_note = Struct.new(:title, :body)

  class Note
    TITLE = 'title'.freeze
    BODY_MSG = 'body_msg'.freeze
    BODY_KEY = 'body_key'.freeze
    BODY_IV = 'body_iv'.freeze
    PASSWORD = 'password'.freeze
    ID = 'id'.freeze

    def self.new_note(request)
      note = Control::Note.new_note(request)
      Model::Note.new(note.title, note.body, note.password)
    end

    def self.marshal_note(request)
      note = new_note(request)
      {
        TITLE => note.title,
        BODY_MSG => note.body.message,
        BODY_KEY => note.body.key,
        BODY_IV => note.body.iv,
        PASSWORD => note.password,
        ID => note.id
      }
    end

    def self.unmarshal_note(request)
      note = read(request)
      title = note[TITLE]
      encrypted_body = Model::Encrypted_body.new(
        note[BODY_MSG],
        note[BODY_KEY],
        note[BODY_IV]
      )
      body = Model::Note.decrypt_body(encrypted_body)
      [title, body]
    end

    def self.retrieve_note(request)
      title, body = unmarshal_note(request)
      Retrieved_note.new(title, body)
    end

    def self.save(request)
      marshalled_note = marshal_note(request)
      id = marshalled_note[ID]
      #A yaml file is implemented here, a database will be
      #more appropriate for a next implementation.
      File.write("#{id}.yml", marshalled_note.to_yaml)
    end

    def self.read(request)
      Control::Note.retrieve_note(request)
    end
  end
end
