require 'rails_helper'

RSpec.describe "barangay_calls/new", type: :view do
  before(:each) do
    assign(:barangay_call, BarangayCall.new(
      name_call: "MyString",
      phone_number: "MyString"
    ))
  end

  it "renders new barangay_call form" do
    render

    assert_select "form[action=?][method=?]", barangay_calls_path, "post" do

      assert_select "input[name=?]", "barangay_call[name_call]"

      assert_select "input[name=?]", "barangay_call[phone_number]"
    end
  end
end
