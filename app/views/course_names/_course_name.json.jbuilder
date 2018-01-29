json.extract! course_name, :id, :name, :course_type, :created_at, :updated_at
json.url course_name_url(course_name, format: :json)