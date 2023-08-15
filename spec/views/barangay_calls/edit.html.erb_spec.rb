require 'rails_helper'

RSpec.describe "barangay_calls/edit", type: :view do
  let(:barangay_call) {
    BarangayCall.create!(
      name_call: "MyString",
      phone_number: "MyString"
    )
  }

  before(:each) do
    assign(:barangay_call, barangay_call)
  end

  it "renders the edit barangay_call form" do
    render

    assert_select "form[action=?][method=?]", barangay_call_path(barangay_call), "post" do

      assert_select "input[name=?]", "barangay_call[name_call]"

      assert_select "input[name=?]", "barangay_call[phone_number]"
    end
  end
end
