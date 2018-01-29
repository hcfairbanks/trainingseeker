require 'rails_helper'
require 'spec_helper'

RSpec.describe ImagesController, type: :controller do

  let(:user_role){ FactoryGirl.create(:role,{name:'user'})}

  before(:each){
    @admin = FactoryGirl.create(:user, :site_admin, email: 'testadmin@test.com')
    sign_in @admin
   }


  let!(:sample_user){FactoryGirl.create(:user, :hr_agent #, image_attributes:{photo: fixture_file_upload('/binaries/dog_2.jpg','image/jpg', "true")}
  )}
=begin
  let!(:sample_post){Post.create({
    title: "My post",
    price: 10.00,
    content: "Some content here.",
    user_id: sample_user.id,
    image_attributes:{photo: fixture_file_upload('/binaries/dog_1.jpg','image/jpg', "true")}
  })}
=end

  pending "GET user image" do
    it "content type is image/jpeg" do
      get :serve_image, params:  {id:sample_user.image.id, type:"medium"}
      expect(response["Content-Type"]).to eq("image/jpeg")
    end
    it "file name is dog_2.jpg" do
      get :serve_image, params: {id:sample_user.image.id, type:"medium"}
      expect(response["Content-Disposition"]).to eq("inline; filename=\"dog_2.jpg\"")
    end
    it "content is binary" do
      get :serve_image, params: {id:sample_user.image.id, type:"medium"}
      expect(response["Content-Transfer-Encoding"]).to eq("binary")
    end
  end

  pending "GET post image" do
    it "content type is image/jpeg" do
      get :serve_image, params: {id:sample_post.image.id, type:"medium"}
      expect(response["Content-Type"]).to eq("image/jpeg")
    end
    it "file name is dog_1.jpg" do
      get :serve_image, params: {id:sample_post.image.id, type:"medium"}
      expect(response["Content-Disposition"]).to eq("inline; filename=\"dog_1.jpg\"")
    end
    it "content is binary" do
      get :serve_image, params: {id:sample_post.image.id, type:"medium"}
      expect(response["Content-Transfer-Encoding"]).to eq("binary")
    end
  end

end
