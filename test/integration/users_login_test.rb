require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params:{session:{email: "",password: ""}}
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get users_path
    assert flash.empty?
  end

  test "login header link" do
    post login_path, params:{session:{email: @user.email,
                                      password: 'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a", text: "ログアウト"
    assert_select "a", text: @user.name
  end

  test "not login header link" do
    get users_path
    assert_select "a", text: "ログイン"
    assert_select "a", text: "サインアップ"
  end

end
