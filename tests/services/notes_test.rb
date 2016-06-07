require 'minitest/autorun'
require 'rack'
require 'digest'
require_relative '../../services/notes.rb'

class NotesTest < Minitest::Unit::TestCase
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

    assert_equal note.title, TEST_TITLE
    assert_equal note.body, TEST_BODY
    assert_equal note.password, ENCRYPTED_PASSWORD
    assert_equal note.id.length, ID_LENGTH
  end
end
