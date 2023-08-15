class Setting < ApplicationRecord
    validates :userid, presence: true
    validates :firstname, presence: true
    validates :middlename, presence: true
    validates :lastname, presence: true
    validates :phonenumber, presence: true, format: { with: /\A\+639\d{9}\z/, message: "must be a valid Philippine mobile number Ex: +639xxxxxxxxx" }
    validates :twiliophonenumber, presence: true, format: { with: /\A\+12\d{9}\z/, message: "must be a valid Philippine mobile number Ex: +639xxxxxxxxx" }
    validates :auth_token, presence: true
    validates :account_sid, presence: true
end
