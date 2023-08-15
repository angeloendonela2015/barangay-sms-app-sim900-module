require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  before(:each) do
    assign(:settings, [
      Setting.create!(
        userid: 2,
        firstname: "Firstname",
        middlename: "Middlename",
        lastname: "Lastname",
        phonenumber: "Phonenumber",
        twiliophonenumber: "Twiliophonenumber",
        auth_token: "Auth Token",
        account_sid: "Account Sid"
      ),
      Setting.create!(
        userid: 2,
        firstname: "Firstname",
        middlename: "Middlename",
        lastname: "Lastname",
        phonenumber: "Phonenumber",
        twiliophonenumber: "Twiliophonenumber",
        auth_token: "Auth Token",
        account_sid: "Account Sid"
      )
    ])
  end

  it "renders a list of settings" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Firstname".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Middlename".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Lastname".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phonenumber".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Twiliophonenumber".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Auth Token".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Account Sid".to_s), count: 2
  end
end
