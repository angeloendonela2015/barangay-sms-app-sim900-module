class Barangay < ApplicationRecord
    validates :fullname, presence: true
    validates :number, presence: true, format: { with: /\A\+639\d{9}\z/, message: "must be a valid Philippine mobile number Ex: +639xxxxxxxxx" }
    validates :address, presence: true
    validates :gender, presence: true
    validates :status, presence: true
end
