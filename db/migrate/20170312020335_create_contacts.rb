class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :company_name
      t.string :email
      t.string :phone
      t.string :comment

      t.timestamps
    end
  end
end
