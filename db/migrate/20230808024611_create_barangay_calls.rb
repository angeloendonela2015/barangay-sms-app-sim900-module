class CreateBarangayCalls < ActiveRecord::Migration[7.0]
  def change
    create_table :barangay_calls do |t|
      t.string :name_call
      t.string :phone_number

      t.timestamps
    end
  end
end
