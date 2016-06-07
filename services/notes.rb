require 'yaml'
require_relative '../models/notes.rb'
require_relative '../control/notes.rb'

module Service
  class Note
    TITLE = 'title'.freeze
    BODY = 'body'.freeze
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
        BODY => note.body,
        PASSWORD => note.password,
        ID => note.id
      }
    end

    def self.save(request)
      marshalled_note = marshal_note(request)
      id = marshalled_note[ID]
      #A yaml file is implemented here, a database will be
      #more appropriate for a next implementation.
      File.write("#{id}.yml", marshalled_note.to_yaml)
    end
  end
end
