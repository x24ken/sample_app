require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  test "rootページの取得" do
    get root_path
    assert_response :success
  end

  test "helpページの取" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end
  
  test "aboutページの取" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"    
  end

  test "contactページの取" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
end
