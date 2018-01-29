class BannerUploader < CarrierWave::Uploader::Base
# Crop
# http://stackoverflow.com/questions/12762728/how-to-crop-image-on-upload-with-rails-carrierwave-and-minimagick
# https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Make-a-fast-lookup-able-storage-directory-structure
# look into this. See if I ned to do this
# https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Delete-cache-garbage-directories
# https://github.com/carrierwaveuploader/carrierwave/issues/222
# http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
# Size Validation
# https://github.com/carrierwaveuploader/carrierwave/wiki/how-to:-validate-attachment-file-size

  after :remove, :clear_uploader
  #include CarrierWave::Compatibility::Paperclip
  #include FileUtils
  require 'fileutils'

  #Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  #include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #File.join(Rails.root,"images",Rails.env,"#{model.class.to_s.underscore}", "#{mounted_as}", model.id.to_s) # This worked
    File.join("images",Rails.env,"#{model.class.to_s.underscore}", "#{mounted_as}", model.id.to_s)
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  # def pre_limit file
  #   # #   #require 'debugger'; debugger
  #   if file && file.size > 1.megabytes
  #   #      byebug
  #     raise Exception.new("too large")
  #   end
  #     true
  # end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :banner do
    process resize_to_fit: [150, 150]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end


   def clear_uploader
     pic_path =  "public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
     FileUtils.rm_rf(pic_path)
   end


end
