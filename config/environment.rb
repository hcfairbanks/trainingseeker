require_relative 'application'
require 'carrierwave/storage/ftp/all'

Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address              => ENV['SMTP_ADDRESS'],
  :port                 => ENV['SMTP_PORT'],
  :domain               => ENV['SMTP_DOMAIN'],
  :user_name            => ENV['SMTP_USER_NAME'],
  :password             => ENV['SMTP_PASSWORD'],
  :authentication       => :plain,
  :enable_starttls_auto => true
}

CarrierWave.configure do |config|
   config.ftp_host    = ENV['FTP_HOST']
   config.ftp_port    = ENV['FTP_PORT']
   config.ftp_user    = ENV['FTP_USER']
   config.ftp_passwd  = ENV['FTP_PASSWORD']
   config.ftp_folder  = ENV['FTP_FOLDER']
   config.ftp_url     = ENV['FTP_URL']
   config.ftp_passive = true
 end
 #config.ftp_url = "http://192.168.0.9:3000"
 #config.ftp_url = "localhost:3000"
