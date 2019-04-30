class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_number
      t.integer :price
      t.string :room_type
      t.boolean :booked_status
      t.references :hotel, foreign_key: true

      t.timestamps
    end
  end
end
