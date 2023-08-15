require 'rails_helper'

RSpec.describe "barangay_calls/show", type: :view do
  before(:each) do
    assign(:barangay_call, BarangayCall.create!(
      name_call: "Name Call",
      phone_number: "Phone Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name Call/)
    expect(rendered).to match(/Phone Number/)
  end
end
