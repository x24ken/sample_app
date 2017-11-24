require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full_titleヘルパーのテスト" do
    assert_equal full_title,         "Ruby on Rails Tutorial Sample App"
    assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
  end
end