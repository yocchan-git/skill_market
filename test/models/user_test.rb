require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "竹中平八郎", email: "fuyu_1201@yahoo.ne.jp",
                    password: "fuyu3215", password_confirmation: "fuyu3215")
  end

  test "user can valid" do
    assert @user.valid?
  end

  test "user should be present (nonblank)" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "user should have a maximum lenght" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present (nonblank)" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "email should have a maximum length" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be unique" do
    copy_user = @user.dup
    @user.save
    assert_not copy_user.valid?
  end

  test "email validation should accept validation addresses" do
    validation_addresses = %w[user@foo.bar USER@younger.sister yo_shi@haru.com mana+mana@mana.M]
    validation_addresses.each do |validation_address|
      @user.email = validation_address
      assert @user.valid?,"#{validation_address.inspect} should be valid"
    end
  end

  test "email invalidation should reject invalidation addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?,"#{invalid_address} should be invalid"
    end
  end

  test "email address should be saved as lowercase" do
    randam_case_email = "FuYu_1201@yaHoo.nE.jP"
    @user.email = randam_case_email
    @user.save
    assert_equal randam_case_email.downcase, @user.reload.email
  end

  test "password should have a minimum lenght" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
end
