require 'rails_helper'

RSpec.describe "settings/show", type: :view do
  before(:each) do
    assign(:setting, Setting.create!(
      userid: 2,
      firstname: "Firstname",
      middlename: "Middlename",
      lastname: "Lastname",
      phonenumber: "Phonenumber",
      twiliophonenumber: "Twiliophonenumber",
      auth_token: "Auth Token",
      account_sid: "Account Sid"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Middlename/)
    expect(rendered).to match(/Lastname/)
    expect(rendered).to match(/Phonenumber/)
    expect(rendered).to match(/Twiliophonenumber/)
    expect(rendered).to match(/Auth Token/)
    expect(rendered).to match(/Account Sid/)
  end
end
