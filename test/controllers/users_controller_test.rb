require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "非ログイン状態での:edit" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "非ログイン状態での:update" do
    patch user_path(@user), params: { user: { name: @user.name,
                                             email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
