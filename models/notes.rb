require 'digest'
require 'openssl'
require 'securerandom'

module Model
  Encrypted_body = Struct.new(:message, :key, :iv)

  class Note
    attr_reader :title, :body, :password, :id
    def initialize(title, body, password)
      @title = title
      @body = Note.encrypt_body(body)
      @password = Digest::MD5.digest(password)
      @id = SecureRandom.hex(10)
    end

    def self.encrypt_body(body)
      cipher = OpenSSL::Cipher.new('AES-128-CBC')
      cipher.encrypt

      key = cipher.random_key
      iv = cipher.random_iv
      message = cipher.update(body) + cipher.final

      Encrypted_body.new(message, key, iv)
    end

    def self.decrypt_body(encrypted_body)
      decipher = OpenSSL::Cipher.new('AES-128-CBC')
      decipher.decrypt

      decipher.key = encrypted_body.key
      decipher.iv = encrypted_body.iv

      decipher.update(encrypted_body.message) + decipher.final
    end
  end
end
