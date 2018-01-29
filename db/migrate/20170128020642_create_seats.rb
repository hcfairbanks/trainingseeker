class CreateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :seats do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :id_code
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
  end
end
