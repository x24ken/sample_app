require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:orange)
  end
  
  test "ログインしてない人はマイクロポストを作ることはできない" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end
  
  test "ログインしてない人はマイクロポストを消すことはできない" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
  assert_redirected_to login_url
  end
  
  test "他の人のマイクロポストは消すことができない" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(micropost)
    end
    assert_redirected_to root_url
  end
  
end
