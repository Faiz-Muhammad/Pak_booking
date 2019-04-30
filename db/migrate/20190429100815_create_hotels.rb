class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :location
      t.string :city
      t.integer :rating

      t.timestamps
    end
  end
end
