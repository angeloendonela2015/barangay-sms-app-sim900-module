require 'rails_helper'

RSpec.describe "settings/edit", type: :view do
  let(:setting) {
    Setting.create!(
      userid: 1,
      firstname: "MyString",
      middlename: "MyString",
      lastname: "MyString",
      phonenumber: "MyString",
      twiliophonenumber: "MyString",
      auth_token: "MyString",
      account_sid: "MyString"
    )
  }

  before(:each) do
    assign(:setting, setting)
  end

  it "renders the edit setting form" do
    render

    assert_select "form[action=?][method=?]", setting_path(setting), "post" do

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
