class CourseName < ApplicationRecord
  # test comment for hipchat integration test
  has_many :courses
  has_many :course_aliases
end
