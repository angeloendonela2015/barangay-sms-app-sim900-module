require "rails_helper"

RSpec.describe BarangayCallsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/barangay_calls").to route_to("barangay_calls#index")
    end

    it "routes to #new" do
      expect(get: "/barangay_calls/new").to route_to("barangay_calls#new")
    end

    it "routes to #show" do
      expect(get: "/barangay_calls/1").to route_to("barangay_calls#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/barangay_calls/1/edit").to route_to("barangay_calls#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/barangay_calls").to route_to("barangay_calls#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/barangay_calls/1").to route_to("barangay_calls#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/barangay_calls/1").to route_to("barangay_calls#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/barangay_calls/1").to route_to("barangay_calls#destroy", id: "1")
    end
  end
end
