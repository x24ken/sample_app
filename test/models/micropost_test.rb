require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    #このコードは慣習的に正しくない
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
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
end
