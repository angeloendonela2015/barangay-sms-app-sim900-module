require 'rails_helper'

RSpec.describe "settings/new", type: :view do
  before(:each) do
    assign(:setting, Setting.new(
      userid: 1,
      firstname: "MyString",
      middlename: "MyString",
      lastname: "MyString",
      phonenumber: "MyString",
      twiliophonenumber: "MyString",
      auth_token: "MyString",
      account_sid: "MyString"
    ))
  end

  it "renders new setting form" do
    render

    assert_select "form[action=?][method=?]", settings_path, "post" do

      assert_select "input[name=?]", "setting[userid]"

      assert_select "input[name=?]", "setting[firstname]"

      assert_select "input[name=?]", "setting[middlename]"

      assert_select "input[name=?]", "setting[lastname]"

      assert_select "input[name=?]", "setting[phonenumber]"

      assert_select "input[name=?]", "setting[twiliophonenumber]"

      assert_select "input[name=?]", "setting[auth_token]"

      assert_select "input[name=?]", "setting[account_sid]"
    end
  end
end
