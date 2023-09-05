class Barangay < ApplicationRecord
    has_many :fullnames, class_name: 'FullName'
    def self.ransackable_attributes(auth_object = nil)
        ["fullname"]
    end

    validates :number, presence: true, uniqueness: true, format: { with: /\A\+639\d{9}\z/, message: "must be a valid Philippine mobile number Ex: +639xxxxxxxxx" }
    validates :address, presence: true
    validates :gender, presence: true
    validates :status, presence: true
end
