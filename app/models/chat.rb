class Chat < ApplicationRecord
    has_many :name_chats, class_name: 'nameChat'
    def self.ransackable_attributes(auth_object = nil)
        ["name_chat"]
    end
    
    validates :name_chat, presence: true
    validates :phone_number, presence: true
    validates :body, presence: true
end
