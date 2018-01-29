class AddPriceInCents < ActiveRecord::Migration[5.0]
  # duplicate model to prevent migration breakage if model ever changes in the future
  class Course < ActiveRecord::Base
  end

  def up
    add_column :courses, :price_in_cents, :integer
    Course.find_each do |course|
      course.price_in_cents = course.price * 100
      course.save
    end
    remove_column :courses, :price
  end

  def down
    add_column :courses, :price, :float
    Course.find_each do |course|
      course.price = course.price_in_cents / 100.0
      course.save
    end
    remove_column :courses, :price_in_cents
  end
end
