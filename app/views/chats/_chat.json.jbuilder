json.extract! chat, :id, :name_chat, :phone_number, :body, :created_at, :updated_at
json.url chat_url(chat, format: :json)
