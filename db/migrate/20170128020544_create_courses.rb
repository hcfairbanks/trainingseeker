class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
#      t.belongs_to :user, index: true, foreign_key: true
#      t.string :name
#      t.integer :course_type
      t.integer :course_name_id
      t.integer :availability
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.float :price
      t.string :city
      t.string :province
      t.string :address_line_1
      t.string :address_line_2
      t.string :postal_code
      t.integer :provider_id
      t.string :avatar
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
