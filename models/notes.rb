require 'digest'
require 'securerandom'

module Model
  class Note
    attr_reader :title, :body, :password, :id
    def initialize(title, body, password)
      @title = title
      @body = body
      @password = Digest::MD5.digest(password)
      @id = SecureRandom.hex(10)
    end

    def encrypt_body
      @body
    end
  end
end
