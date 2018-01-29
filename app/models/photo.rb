class Photo < ApplicationRecord
  mount_uploader :pic, PicUploader
  belongs_to :external, polymorphic: true
end
