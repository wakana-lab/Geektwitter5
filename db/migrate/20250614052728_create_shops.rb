class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :phone_number

      t.timestamps
    end
  end
end
