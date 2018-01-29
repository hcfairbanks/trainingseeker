class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :number_of_seats
      t.float :price
      t.integer :status
      t.string :response_id
      t.text :full_response

      t.timestamps
    end
  end
end
