class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :name_chat
      t.string :phone_number
      t.text :body

      t.timestamps
    end
  end
end
