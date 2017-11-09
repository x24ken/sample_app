require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end
  
  test "正常なモデルの有効性(valid)" do
    assert @micropost.valid?
  end
  
  test "user_idは存在するべき" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  
  test "contentは存在するべき" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end
  
  test "contentは140文字まで" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
  
  test "最も新しいマイクロポストを最初に表示する" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
