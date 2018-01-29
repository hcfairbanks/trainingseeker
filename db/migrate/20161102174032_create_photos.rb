class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :pic
      t.integer :external_id
      t.string :external_type
      t.timestamps
    end
  end
end
