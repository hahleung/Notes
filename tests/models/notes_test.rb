require 'minitest/autorun'
require_relative '../../models/notes.rb'

class NotesTest < Minitest::Unit::TestCase
  TEST_TITLE = 'My Title'
  TEST_BODY = 'My Body'
  TEST_PASSWORD = 'My Password'

  def initialization
    note = Model::Note.new(
      TEST_TITLE,
      TEST_BODY,
      TEST_PASSWORD
    )

    assert_equal note.title, TEST_TITLE
    assert_equal note.body, TEST_BODY
    assert_equal note.password, TEST_PASSWORD
    assert_equal note.id.length, 10
  end
end
