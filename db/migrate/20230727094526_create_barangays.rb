class CreateBarangays < ActiveRecord::Migration[7.0]
  def change
    create_table :barangays do |t|
      t.string :fullname
      t.string :number
      t.string :address
      t.string :gender
      t.integer :status

      t.timestamps
    end
  end
end
