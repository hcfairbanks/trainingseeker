require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: :controller do

  let(:user_role){ FactoryGirl.create(:role,{name:'user'})}
  let!(:user){FactoryGirl.create(:user,role_id:user_role.id)}

  before(:each){
    @admin = FactoryGirl.create(:user, :site_admin, email: 'testadmin@test.com')
    sign_in @admin
  }

  let(:valid_attributes) {
    {
      first_name:"John",
      last_name:"Smith",
      dob: "2016/6/16",
      city:"Halifax",
      province:"Nova Scotia",
      email:"valid_attributes_test@test.com",
      password: 'password',
      password_confirmation: 'password',
      role_id:user_role.id
      #image_attributes:{photo: fixture_file_upload('/binaries/dog_1.jpg','image/jpg', "true")}
    }
  }

  let(:invalid_attributes) {
    {
      email: "blah",
      role_id:nil
    }
  }

  describe "GET #index users" do
    it "assign all users as @users" do
      get :index
      expect(assigns(:users)).to include(user,@admin)
    end
    it "renders the :index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show user" do
    it "assigns users to @users" do
      get :show, params: {id: user.id}
      expect(assigns(:user)).to eq(user)
    end
    it "renders the :show template" do
      get :show, params: {id: user.id}
      expect(response).to render_template("show")
    end
  end

  describe "GET #new user" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit user" do
    it "assigns the requested user to @user" do
      get :edit, params: {id: user.id}
      expect(assigns(:user)).to eq(user)
    end
    it "renders the :edit template" do
      get :edit, params: {id: user.id}
      expect(response).to render_template("edit")
    end
  end

  describe "POST #create user" do

    context "with valid attributes" do
      it "saves the new user in the database" do
        expect { post :create, params: {user: valid_attributes} }.to change(User, :count).by(1)
      end
      it "redirects to users#show" do
        post :create, params: {user: valid_attributes}
        expect(response).to redirect_to(User.last)
      end
      pending "saves the new user image" do
        post :create, params: {user: valid_attributes}
        expect(assigns(:user).image).to be_valid
      end
      pending "image type equals User" do
        post :create, params: {user: valid_attributes}
        expect(assigns(:user).image.external_type).to eq("User")
      end
      it "produces valid create flash message" do
        post :create, params: {user: valid_attributes}
        expect(flash[:notice]).to match(I18n.t("user.successfully-created"))
      end
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect { post :create, params: {user: invalid_attributes}}.to change(User, :count).by(0)
      end
      it "re-renders the :new template" do
        post :create, params: {user: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update user" do

    context "with valid attributes" do
      let(:update_attributes) {
        {
          first_name: "edit_first_name",
          last_name: "edit_last_name",
          dob: "1972/02/02",
          city: "edit_Dartmouth",
          province: "Edit Nova Scotia",
          email: "edit_valid_attributes_test@test.com",
          role_id: user.role_id
          #image_attributes:{photo: fixture_file_upload('/binaries/dog_2.jpg','image/jpg', "true")}
        }
      }
      it "updates the requested user" do
        put :update, params: {id: user.id, user: update_attributes}
        expect(assigns(:user)).to be_valid
      end
      pending "updates the requested users image" do
        put :update, params: {id: user.id, user: update_attributes}
        expect(assigns(:user).image).to be_valid
      end
      it "redirects to users#show" do
        put :update, params: {id: user.id, user: update_attributes}
        expect(response).to redirect_to(user)
      end
      it "produces valid update flash message" do
        put :update, params: {id: user.id, user: update_attributes}
        expect(flash[:notice]).to match(I18n.t("user.successfully-updated"))
      end

    end

    context "with invalid attributes" do
      it "assigns the user" do
        put :update, params: { id: user.id, user: invalid_attributes}
        user.reload
        expect(user.first_name).to eq("Bob")
      end
      it "user is not valid" do
        put :update, params: { id: user.id, user: invalid_attributes}
        user.reload
        expect(assigns(:user)).to_not be_valid
      end
      it "returns 2 errors" do
        put :update, params: { id: user.id, user: invalid_attributes}
        user.reload
        expect(assigns(:user).errors.size).to eq(2)
      end
      it "redirects to users#edit" do
        put :update, params: {id: user.id, user: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end

  end

   describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect { delete :destroy, params: {id: user.id} }.to change(User, :count).by(-1)
    end
    it "redirects admin to users#index" do
      delete :destroy, params: {id: user.id}
      expect(response).to redirect_to(users_url)
    end
    it "user deletes self" do
      expect { delete :destroy, params: {id: @admin.id} }.to change(User, :count).by(-1)
    end
    it "ends user session when user deletes self" do
      delete :destroy, params: {id: @admin.id}
      expect(response).to redirect_to(new_user_session_url)
    end
    it "produces valid destroy flash message" do
      delete :destroy, params: {id: user.id}
      expect(flash[:notice]).to match(I18n.t("user.successfully-destroyed"))
    end

  end

end
