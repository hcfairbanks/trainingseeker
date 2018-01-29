#Completed
- Complete Search Form
- Define Role Types
- Add the VM key to bitbucket
- SSH Keys on Sever
- Deploy user on server
- Clone the repo onto the azure VM
- Deal with any dependencies issues for server
- Script tp pull latest code, run migrations , seed the db and restart the server, on demo server
- Run the app with the default puma ( rails s)
- Set ip address to HTTP port default  80
- Live Test of server
- Live Test of server Script named “pullcode”
- Create procedure for releases
- Set up environment
- Confirm azure account is using bizspark credits $150.00
- Pagination styling
- redis
- sidekiq
- development server
- Long Lat Map
- CANCANCAN no current_user error
- Finish Payment Section ( This will require explanation )
- Links in the email are pointing to current url and not localhost
- Cancancan redirects to custom unauthorization page
- pay Controller
- pay Views
- pay Purchasing
- mandril approve url
- Carrier Wave FTP Variables need to be enviroment variable.
- Could also move the from config/environments/development.rb to config/environment.rb
- Environment Variables
- SMTP Variables
- ftp credentials / user
- Production environment, Environment variables
- DB Switch to PSQL
- add internal password changer for admins only
- captcha for devise
- New sever needs to be a production server
- Currency as integer (this is in multiple spots, such as course creation and edit and course payments)
- User gets email upon signup letting them know their application is under review (this part you did already)
- Business admin also gets an email on new user signup with the signup email to look for.
- Add drop down for what class (HR or Provider) the user is signing up
- Ensure Purchser and Seat email get emails on purcahse (currently it's just the Seat Email).
- The Purchaser email will enevntually get turned into a receipt.
- The Purchaser should only get one email with all seat details listed
- change payments to purchases

#TODO
- Better Seeds
- Finish Visuals
- Mandrill settings as  enviroment variables
- Redo Type ahead
- Assets need to be precompiled everywhere
- Add stylesheets
- Add javascript files
- Format Date Jquery Date Picker
- https://launchschool.com/blog/managing-environment-configuration-variables-in-rails
- http://www.lodgem.com/en/blog/2014-02-16-puma-server-and-its-multiple-modes
- terminator config file
- terminator Short cuts
- vi keys
- vim config file
- user access https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04
- Select Browser Standards
- Testing ( Rspec, FactoryGirl, Database Cleaner)
- Remove .rbenv-vars
- Translations
- Overriding default activerecord error messages
- captcha Google api auth commercial Licence
- Google maps commercial API Licence
- user login attempts lockout
- services pw change
- migrate URL
- https for dev url
- devise lockout password
- How many years do credit cards last? For the drop down.
- Flush out purchasing
- Logs on Production
- static IP
- dev env finalize
- sales env finalize
- production env finalize
- fix images in emails
- flush out permissions
- remove unused gems
- drop Azure code
- Model Validation
- Foreign Keys
- Image Preview (needs to be redone because of FTP )


#Future
- Transaltion
- Gallery
- Metrics
- Book a Trainer


#Installation
- Carrierwave requires imagemagick<br/>
- Reference the following for installation instructions<br/>

- Redis
- Instructions for installing redis from source can be found here
- https://github.com/rails/actioncable-examples

- After you seed the db you can sign in with a default user
- email: admin@test.com
- pw: password


- Need to review these
- Moch learn stubs https://github.com/freerange/mocha
- stubs and mocs https://vimeo.com/68116218
- http://railscasts.com/episodes/71-testing-controllers-with-rspec?autoplay=true
- Translations in rspec tests too . . . Iam not sure about this one ?
#Notes

* for the carrierwave-ftp to work in localhost it must use a bridged network in virtual box an
* and when starting a sever you must bind it. example
* RAILS_ENV=production rails s -b 0.0.0.0
* works best when viewing from host.
* to get the external ip, in the terminal type ifconfig
* Look for "inet addr: 192.169.0.9" with a different ip

* bundle exec sidekiq -q default -q mailers #to start sidekiq (activejob backend, apparently better than resque)
* sidekiq must be run in production mode!!!!!, not sure what the -q default did
* bundle exec sidekiq -e production -q mailers # to start sidekiq

http://stackoverflow.com/questions/22958188/how-to-run-sidekiq-in-production-server
bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e production

-d, Daemonize process

-L, path to writable logfile

-C, path to YAML config file

-e, Application environment

#?????
- Do I still need this config.const_name = 'Settings' in config/initializers/config.rb ?
- Is this secure
- config.middleware.insert_before 0, "Rack::Cors" do
- allow do
- origins '*'
- resource '*', :headers => :any, :methods => [:get, :post, :options]
- end
- end
- in file config/application.rb
- http://stackoverflow.com/questions/21711485/rails-sidekiq-sidekiq-running-in-wrong-environment


# This line will be needed  specifically the .first_or_initialize for a group of images
- <%= link_to image_tag("#{root_url}#{post.images.first_or_initialize.id}/thumb/serve_image"), post_path(post) %>
- @path = ":rails_root/images/#{Rails.env}_images/:external_user/:external_type/:id/:style/:filename"
- #, preserve_files: "false" #this only preserve files, dosen't prevent retention
- bin/rails db:environment:set RAILS_ENV=development
- RAILS_ENV="test" bundle exec rspec spec/controllers/users_controller_spec_2.rb:10

#USEFUL COMMANDS

- rails g migration create_statuses name:string
- rails g migration create_conversations
- rails g migration create_messages content:string user:references # refernce creates the foreign key

- db:drop         - will drop database.
- db:create       - will create database (host/db/password will be taken from config/database.yml)
- db:migrate      - will run existing migrations from directory (db/migration/.rb)
- db:seed         - will run seed data possible from directory (db/migration/seed.rb)..
- db:schema:dump  - will drop schema for fresh create
- db:reset        - Havent used this yet
- db:test:prepare - Havent used this yet

- rake db:drop db:schema:dump db:create db:migrate db:seed

- rake db:drop db:create db:migrate db:seed

- RAILS_ENV=production rake assets:precompile

- Devise / reCAPTCHA
- Site Key ( for Localhost )
- export RECAPTCHA_SITE_KEY='6LfQChYUAAAAABRFM-E6q0030o8KmN8u7kl8Mks0'
- Secret key
- export RECAPTCHA_SECRET_KEY='6LfQChYUAAAAAGYOhw8fWUT3x5oxnoFuwp5k3Wdx'

- rails s
- redis-server
- bundle exec sidekiq -q default -q mailers
