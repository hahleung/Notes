require 'digest'
require_relative 'errors/errors.rb'

module Control
  TITLE = 'title'.freeze
  BODY = 'body'.freeze
  PASSWORD = 'password'.freeze
  ID = 'id'.freeze

  class Note
    Note = Struct.new(:title, :body, :password)

    def self.new_note(request)
      raise Error::EmptyPost if request.POST == {}
      data = request.POST

      raise Error::NoTitle if data[TITLE].nil?
      title = data[TITLE]
      raise Error::TitleEmpty if title.empty?

      raise Error::NoBody if data[BODY].nil?
      body = data[BODY]
      raise Error::BodyEmpty if body.empty?

      raise Error::NoPassword if data[PASSWORD].nil?
      password = data[PASSWORD]
      raise Error::PasswordEmpty if password.empty?

      Note.new(title, body, password)
    end

    def self.retrieve_note(request)
      raise Error::EmptyPost if request.POST == {}
      data = request.POST

      raise Error::NoID if data[ID].nil?
      id = data[ID]
      raise Error::IDEmpty if id.empty?
      raise Error::NoPassword if data[PASSWORD].nil?
      raise Error::PasswordEmpty if data[PASSWORD].empty?
      password = Digest::MD5.digest(data[PASSWORD])

      [id, password]
    end
  end
end
