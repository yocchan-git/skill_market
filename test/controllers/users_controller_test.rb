require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:michael)
        @other_user = users(:archer)
    end

    test "should get new" do
        get new_user_path
        assert_response :success
    end
end
