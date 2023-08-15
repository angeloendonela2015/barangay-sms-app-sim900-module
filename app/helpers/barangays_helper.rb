module BarangaysHelper
    def chat
        @chat = Chat.new
    end

    def barangay_call
        @barangay_call = BarangayCall.new
    end
end
