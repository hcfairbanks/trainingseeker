json.extract! course, :id, :course_name_id, :availability, :start_date, :end_date, :price, :city, :province, :address_line_1, :address_line_2, :postal_code, :provider_id, :created_at, :updated_at
json.url course_url(course, format: :json)
