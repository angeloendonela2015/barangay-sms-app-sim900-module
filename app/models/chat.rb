class Chat < ApplicationRecord
    validates :name_chat, presence: true
    validates :phone_number, presence: true, format: { with: /\A\+639\d{9}\z/, message: "must be a valid Philippine mobile number Ex: +639xxxxxxxxx" }
    validates :body, presence: true
end
