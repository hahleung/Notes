require 'yaml'
require_relative '../models/notes.rb'

module Service
  Retrieved_note = Struct.new(:title, :body)

  class Note
    TITLE = 'title'.freeze
    BODY_MSG = 'body_msg'.freeze
    BODY_KEY = 'body_key'.freeze
    BODY_IV = 'body_iv'.freeze
    PASSWORD = 'password'.freeze
    ID = 'id'.freeze

    def self.marshal(note)
      new_note = Model::Note.new(note.title, note.body, note.password)
      {
        TITLE => new_note.title,
        BODY_MSG => new_note.body.message,
        BODY_KEY => new_note.body.key,
        BODY_IV => new_note.body.iv,
        PASSWORD => new_note.password,
        ID => new_note.id
      }
    end

    def self.unmarshal(note)
      title = note[TITLE]
      encrypted_body = Model::Encrypted_body.new(
        note[BODY_MSG],
        note[BODY_KEY],
        note[BODY_IV]
      )
      body = Model::Note.decrypt_body(encrypted_body)
      [title, body]
    end

    def self.retrieve(note)
      title, body = unmarshal(note)
      Retrieved_note.new(title, body)
    end

    def self.save(note)
      marshalled_note = marshal(note)
      id = marshalled_note[ID]
      [id, marshalled_note]
    end
  end
end
