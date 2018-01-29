class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :city
      t.string :province_state
      t.string :postal_code
      t.string :address_line_1
      t.string :address_line_2
      t.string :avatar
      t.string :key1
      t.string :key2

      t.timestamps
    end
  end
end
