module Control
  class Note
    TITLE = 'title'.freeze
    BODY = 'body'.freeze
    PASSWORD = 'password'.freeze
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
  end
end
