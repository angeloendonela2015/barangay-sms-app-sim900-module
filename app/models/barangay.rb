class Barangay < ApplicationRecord
    validates :fullname, presence: true
    validates :number, presence: true
    validates :address, presence: true
    validates :gender, presence: true
    validates :status, presence: true
end
