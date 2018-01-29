class CreateCourseAliases < ActiveRecord::Migration[5.0]
  def change
    create_table :course_aliases do |t|
      t.string :course_alias
      t.integer :course_name_id

      t.timestamps
    end
  end
end
