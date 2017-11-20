require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  
  test "アクセス制御に対する:postテスト" do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to login_url
  end
  
  test "アクセス制御に対する:deleteテスト" do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(relationships(:one))
    end
    assert_redirected_to login_url
  end
end
