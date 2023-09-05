module ChatsHelper
    def barangay
        @barangay = Barangay.new
        @barangays = Barangay.all
    end
end
