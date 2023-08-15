class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.integer :userid
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :phonenumber
      t.string :twiliophonenumber
      t.string :auth_token
      t.string :account_sid

      t.timestamps
    end
  end
end
