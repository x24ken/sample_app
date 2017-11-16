require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  
  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id,
                                     followed_id: users(:archer).id)
  end
  
  test "バリテーション" do
    assert @relationship.valid?
  end
  
  test "follower_idは存在するべき" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end
  
  test "followed_idは存在するべき" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
