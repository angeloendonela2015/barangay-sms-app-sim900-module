require 'rails_helper'

RSpec.describe "barangay_calls/index", type: :view do
  before(:each) do
    assign(:barangay_calls, [
      BarangayCall.create!(
        name_call: "Name Call",
        phone_number: "Phone Number"
      ),
      BarangayCall.create!(
        name_call: "Name Call",
        phone_number: "Phone Number"
      )
    ])
  end

  it "renders a list of barangay_calls" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name Call".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone Number".to_s), count: 2
  end
end
