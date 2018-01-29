require 'rails_helper'

RSpec.describe User, type: :model do

  let(:admin_role){FactoryGirl.create(:role,{ name: "admin"})}
  let(:user_role){FactoryGirl.create(:role,{ name: "user"})}

  let(:valid_attributes){
    {
      email:"test@test.com",
      password:"123passWord",
      password_confirmation: "123passWord",
      first_name: "Bob",
      last_name: "Boberson",
      city: "Halifax",
      province: "Nova Scotia",
      role_id:FactoryGirl.create(:hr_agent_role).id
      #image_attributes:{photo: File.new(Rails.root.join('spec', 'fixtures', "binaries", "dog_1.jpg"))}
      }
  }
  let(:invalid_attributes){
    {
      email:"",
      password:"passWor",
      password_confirmation: "123passWod",
      first_name: "",
      last_name: "Boberson",
      city: "Halifax",
      province: "Nova Scotia"
    }
  }
  let(:update_attributes){
    {
      email:"123test@test.com",
      password:"NewPassWord",
      password_confirmation: "NewPassWord",
      first_name: "Dob",
      last_name: "Doberson",
      city: "Moncton",
      province: "New Brunswick",
      role_id:FactoryGirl.create(:site_admin_role).id
      #image_attributes:{photo: File.new(Rails.root.join('spec', 'fixtures', "binaries", "dog_2.jpg"))}
    }
  }

  it "create a user with valid attributes" do
    test_user = User.create(valid_attributes)
    expect(test_user).to be_valid
  end

  pending "create a user with valid image" do
    test_user = User.create(valid_attributes)
    expect(test_user.image).to be_valid
  end

  it "create a user with invalid attributes" do
    test_user = User.create(invalid_attributes)
    expect(test_user).to be_invalid
  end

  it "update a user" do
    test_user = User.create(valid_attributes)
    test_user.update(update_attributes)
    test_user.reload
    expect(test_user).to be_valid
  end

  pending "update a user with valid image" do
    test_user = User.create(valid_attributes)
    test_user.update(update_attributes)
    test_user.reload
    expect(test_user.image).to be_valid
  end

  it "update a user with invalid attributes" do
    test_user = User.create(valid_attributes)
    test_user.update(invalid_attributes)
    test_user.reload
    expect(test_user).to be_invalid
  end

  describe "delete a user" do

    it "count goes down by 1" do
      test_user = User.create(valid_attributes)
      expect {User.destroy(test_user.id)}.to change(User, :count).by(-1)
    end

    it "user cant be found in db" do
      test_user = User.create(valid_attributes)
      User.destroy(test_user.id)
      expect(User.where(id: test_user.id).count).to eq(0)
    end

    pending "user image deleted" do
      test_user = User.create(valid_attributes)
      User.destroy(test_user.id)
      expect(Image.where(id: test_user.image.id).count).to eq(0)
    end

  end

end
