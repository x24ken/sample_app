require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  
  test "まずは保存できている" do
    assert @user.valid?
  end
  
  test "名前は空白じゃ駄目よ" do
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "メアドは空白じゃ駄目よ" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "名前長すぎ" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "メール長すぎ" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "良いメアドのアドレス" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US_ER@foo.bar.org 
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} はおｋすべき"
    end
  end
  
  test "悪いメアドのアドレス" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} ははじくべき"
    end
  end
  
  test "メアドが重複してる" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "メアドは小文字にして保存するべき" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "パスワードに空欄はダメ" do
    @user.password = @user.password_confirmation = " " * 7
    assert_not @user.valid?
  end
  
  test "パスワードは短いのはダメ" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "auhenticated?メソッドはnilの時はエラーを返すべき" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "ユーザー削除されたときはマイクロポストも一緒に消える" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  
  test "フォローとアンフォローとフォローしてる？機能の確認" do
    michael = users(:michael)
    archer  = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
end

