require 'minitest/autorun'
require 'digest'
require_relative '../../models/notes.rb'

class ModelNotesTest < Minitest::Unit::TestCase
  TEST_TITLE = 'My Title'.freeze
  TEST_BODY = 'My Body'.freeze
  TEST_PASSWORD = 'My Password'.freeze
  ENCRYPTED_PASSWORD = Digest::MD5.digest(TEST_PASSWORD)
  ID_LENGTH = 10

  def test_initialization
    note = Model::Note.new(
      TEST_TITLE,
      TEST_BODY,
      TEST_PASSWORD
    )

    decrypted_body = Model::Note.decrypt_body(note.body)

    assert_equal TEST_TITLE, note.title
    assert_equal TEST_BODY, decrypted_body
    assert_equal ENCRYPTED_PASSWORD, note.password
    assert_equal ID_LENGTH, note.id.length
  end
end
