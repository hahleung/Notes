require 'minitest/autorun'
require 'rack'
require 'digest'
require_relative '../../services/notes.rb'
require_relative '../../models/notes.rb'

class ServiceNotesTest < Minitest::Unit::TestCase
  TEST_TITLE = 'My Title'
  TEST_BODY = 'My Body'
  TEST_PASSWORD = 'My Password'
  ENCRYPTED_PASSWORD = Digest::MD5.digest(TEST_PASSWORD)
  ID_LENGTH = 20

  ENVIRONMENT = Rack::MockRequest.env_for(
    '',
    'REQUEST_METHOD' => 'POST',
    :input => "title=#{TEST_TITLE}&body=#{TEST_BODY}&password=#{TEST_PASSWORD}"
  )

  def test_new_note
    request = Rack::Request.new(ENVIRONMENT)

    note = Service::Note.new_note(request)
    decrypted_body = Model::Note.decrypt_body(note.body)

    assert_equal TEST_TITLE, note.title
    assert_equal TEST_BODY, decrypted_body
    assert_equal ENCRYPTED_PASSWORD, note.password
    assert_equal ID_LENGTH, note.id.length
  end
end
