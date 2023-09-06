class CreateJoinTableChatsNumbers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :chats, :numbers do |t|
      # t.index [:chat_id, :number_id]
      # t.index [:number_id, :chat_id]
    end
  end
end
