include ActionDispatch::TestProcess

puts "Seeding Roles"

site_admin_role = Role.create(name: "site_admin")
business_admin_role  = Role.create(name: "business_admin")
provider_agent_role  = Role.create(name: "provider_agent")
hr_agent_role  = Role.create(name: "hr_agent")

puts "Seeding Course Providers"
for iteration in 0..20
  p = Provider.create(name: Faker::Company.name)
  ProviderAccount.create(provider: p, merchant_id: '300204029', api_key: 'BC60BC8F6A29496Ba8f2FC04A45Ea386', discount_type: 0)
  ProviderAccount.create(provider: p, merchant_id: '300204033', api_key: '3243229A42934Eb2bcdb79f72E09A45b', discount_type: 1)
end
provider_abc = Provider.create(name: "abc")
provider_xyz = Provider.create(name: "xyz")
ProviderAccount.create(provider: provider_abc, merchant_id: '300204029', api_key: 'BC60BC8F6A29496Ba8f2FC04A45Ea386', discount_type: 0)
ProviderAccount.create(provider: provider_abc, merchant_id: '300204033', api_key: '3243229A42934Eb2bcdb79f72E09A45b', discount_type: 1)

puts "Seeding Course Names & Course Aliases"
c1 = CourseName.create(name:"Standard First Aid")
CourseAlias.create(course_alias: c1.name, course_name_id: c1.id )
c2 = CourseName.create(name:"Standard First Aid Recertification")
CourseAlias.create(course_alias: c2.name, course_name_id: c2.id )
c3 = CourseName.create(name:"Emergency First Aid")
CourseAlias.create(course_alias: c3.name, course_name_id: c3.id )
c4 = CourseName.create(name:"Emergency First Responder")
CourseAlias.create(course_alias: c4.name, course_name_id: c4.id )
c5 = CourseName.create(name:"Oxygen Administration")
CourseAlias.create(course_alias: c5.name, course_name_id: c5.id )
c6 = CourseName.create(name:"CPR/AED Level A")
CourseAlias.create(course_alias: c6.name, course_name_id: c6.id )
c7 = CourseName.create(name:"CPR/AED Level B")
CourseAlias.create(course_alias: c7.name, course_name_id: c7.id )
c8 = CourseName.create(name:"CPR/AED Level HCP")
CourseAlias.create(course_alias: c8.name, course_name_id: c8.id )
c9 = CourseName.create(name:"Mental Health First Aid")
CourseAlias.create(course_alias: c9.name, course_name_id: c9.id )
c10 = CourseName.create(name:"CPR/AED Level C")
CourseAlias.create(course_alias: c10.name, course_name_id: c10.id )
CourseAlias.create(course_alias: "Child Care First Aid", course_name_id: c10.id )
c11 = CourseName.create(name:"WHMIS")
CourseAlias.create(course_alias: c11.name, course_name_id: c11.id )
CourseAlias.create(course_alias: "Workplace Hazardous Material System Information System", course_name_id: c11.id )
CourseAlias.create(course_alias: "WHMIS 2015", course_name_id: c11.id )
c12 = CourseName.create(name:"GHS")
CourseAlias.create(course_alias: c12.name, course_name_id: c12.id )
CourseAlias.create(course_alias: "Global Harmonized System", course_name_id: c12.id )
CourseAlias.create(course_alias: "Globally Harmonized System (GHS)", course_name_id: c12.id )
c13 = CourseName.create(name:"Site Coordinator Training")
c14 = CourseName.create(name:"TDG")
CourseAlias.create(course_alias: "Transportation of Dangerous Goods", course_name_id: c14.id )
c15 = CourseName.create(name:"OSSA")
CourseAlias.create(course_alias: "Oil Sands Safety Association", course_name_id: c15.id )
c16 = CourseName.create(name:"OSSA Confined Space Entry/Monitor")
CourseAlias.create(course_alias: "Confined Space Entry/Monitor", course_name_id: c16.id )
c17 = CourseName.create(name: "OSSA Fall Protection")
CourseAlias.create(course_alias: "Fall Protection (Alberta)", course_name_id: c17.id )
c18 = CourseName.create(name: "OSSA Fire Watch")
CourseAlias.create(course_alias: "Fire Watch (Alberta)", course_name_id: c18.id )
c19 = CourseName.create(name: "OSSA EWP")
CourseAlias.create(course_alias: "Elevated Work Platform (Alberta)", course_name_id: c19.id )
c20 = CourseName.create(name: "OSSA AWP")
CourseAlias.create(course_alias: "Aerial Work Platform (Alberta)", course_name_id: c20.id )
c21 = CourseName.create(name: "AWP")
CourseAlias.create(course_alias: "Aerial Work Platform", course_name_id: c21.id )
CourseAlias.create(course_alias: "Powered Elevated Platform", course_name_id: c21.id )
CourseAlias.create(course_alias: "Scissor Lift", course_name_id: c21.id )
c22 = CourseName.create(name: "H2S")
CourseAlias.create(course_alias: "Hydrogen Sulfide", course_name_id: c22.id )
c23 = CourseName.create(name: "H2S Alive")
CourseAlias.create(course_alias: "ENFORM H2S Alive", course_name_id: c23.id )
c24 = CourseName.create(name: "H2S Awareness")
c25 = CourseName.create(name: "Load Securement")
c26 = CourseName.create(name: "Fire Extinguisher Training")
c27 = CourseName.create(name: "Defensive Driving")
c28 = CourseName.create(name: "Professional Drivers Improvement Course")

puts "Seeding Courses"
# provinces = ['Alberta','British Columbia','Manitoba','New Brunswick','Newfoundland and Labrador','Nova Scotia','Ontario',
#        'Prince Edward Island','Quebec','Saskatchewan','Northwest Territories','Nunavut',
#        'Yukon']
provinces = ['Alberta','New Brunswick','Nova Scotia']
cities =['Calgary','Fredericton','Halifax']

(1..30).each do
  price = rand(1..30).to_s
  price = price + "." + rand(0..30).to_s
  Course.create(price: price, start_date: (Date.today.next_day(rand(0..30))) ,availability: rand(30), city: cities[0], provider_id: rand(1..20), course_name_id: rand(1..9), province:provinces[0])
end

(1..30).each do
  price = rand(1..30).to_s
  price = price + "." + rand(0..30).to_s
  Course.create(price: price, start_date: (Date.today.next_day(rand(0..30))) ,availability: rand(30), city: cities[1], provider_id: rand(1..20), course_name_id: rand(1..9), province:provinces[1])
end

(1..30).each do
  price = rand(1..30).to_s
  price = price + "." + rand(0..30).to_s
  Course.create(price: price, start_date: (Date.today.next_day(rand(0..30))) ,availability: rand(30), city: cities[2], provider_id: rand(1..20), course_name_id: rand(1..9), province:provinces[2])
end

puts "Seeding Users"

admin_user = User.create(confirmed_at: DateTime.now(),is_approved: true,first_name: "admin_first", last_name: "admin_last", dob: "2016/6/16", city: "Halifax", province: "Nova Scotia", email: "hcfairbanks@gmail.com", password: "password", role_id: site_admin_role.id)
admin_user = User.create(confirmed_at: DateTime.now(),is_approved: true,first_name: "admin_first", last_name: "admin_last", dob: "2016/6/16", city: "Halifax", province: "Nova Scotia", email: "admin@test.com", password: "password", role_id: site_admin_role.id)

#admin_user = User.create(confirmed_at: DateTime.now(),is_approved: true,first_name: "admin_first", last_name: "admin_last", dob: "2016/6/16", city: "Halifax", province: "Nova Scotia", email: "123hcfairbanks@gmail.com", password: "password", role_id: site_admin_role.id, avatar: fixture_file_upload(File.join(Rails.root,"spec","fixtures","binaries","dog_1.jpg"),'image/jpg', "true"))
#user_1 = User.create(confirmed_at: DateTime.now(),is_approved: true,first_name: "Adam", last_name: "West", dob: "2016/6/16", city: "Halifax", province: "Nova Scotia", email: "adam@windymaple.com", password: "password",role_id: hr_agent_role.id, avatar: fixture_file_upload(File.join(Rails.root,"spec","fixtures", "binaries","headshots","adam_west.jpg"),'image/jpg', "true") )
#user_2 = User.create(confirmed_at: DateTime.now(),is_approved: false,first_name: "Al", last_name: "Pacino", dob: "2016/6/16", city: "Halifax", province: "Nova Scotia", email: "al@windymaple.com", password: "password",role_id: hr_agent_role.id, avatar: fixture_file_upload(File.join(Rails.root,"spec","fixtures", "binaries","headshots","al_pacino.jpg"),'image/jpg', "true") )
#user_3 = User.create(confirmed_at: DateTime.now(),is_approved: false,first_name: "Angelina", last_name: "Jolie", dob: "2016/6/16", city: "Halifax", province: "Nova Scotia", email: "angelina@windymaple.com", password: "password",role_id: hr_agent_role.id, avatar: fixture_file_upload(File.join(Rails.root,"spec","fixtures", "binaries","headshots","angelina_jolie.jpg"),'image/jpg', "true") )





# require 'net/ftp'
#
# CONTENT_SERVER_DOMAIN_NAME = "localhost"
# CONTENT_SERVER_FTP_LOGIN = "deploy"
# CONTENT_SERVER_FTP_PASSWORD = "password"
#
#
# # LOGIN and LIST available files at default home directory
# Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
#   files = ftp.list
#   puts "list out files in root directory:"
#   puts files
# end


# # check if the directory existence
# # create the directory if it does not exist yet
# Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
#   ftp.mkdir("/root_level") if !ftp.list("/").any?{|dir| dir.match(/\sroot_level$/)}
#
#   # create nested directory
#   # it does not create directory tree
#   # therefore, create "/root_level" before creating "/root_level/nested"
#   ipad_folder = ftp.list("/root_level")
#   ftp.mkdir("/root_level/nested") if !ipad_folder.any?{|dir| dir.match(/\snested$/)}
# end
#
#
# # upload files
# TXT_FILE_OBJECT = File.new("/home/deploy/public/test.txt")
# Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
#   ftp.putbinaryfile(TXT_FILE_OBJECT)
# end
#
#
# # upload files and rename it
# Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
#   ftp.putbinaryfile(TXT_FILE_OBJECT, "0001.txt.in_process")
# end
#
#
# # upload files to nested directory
# Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
#   ftp.putbinaryfile(TXT_FILE_OBJECT, "/root_level/nested/#{File.basename(TXT_FILE_OBJECT)}")
# end
