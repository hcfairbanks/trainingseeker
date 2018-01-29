require 'rails_helper'
require 'spec_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:hr_agent_role) { FactoryGirl.create(:hr_agent_role) }
  let(:provider_agent_role) { FactoryGirl.create(:provider_agent_role) }
  let(:site_admin_role) { FactoryGirl.create(:site_admin_role) }
  let(:biz_admin_role) { FactoryGirl.create(:biz_admin_role) }
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST #create" do
    before(:each) do
      request.env['warden'] = double(Warden, :authenticate? => false)
    end

    context "Register hr agent" do
      let(:hr_agent_params) { 
        {
          email: "test@example.com",
          password: "password",
          password_confirmation: "password",
          role_id: hr_agent_role.id
        }
      }

      it "should successfully create the user" do
        expect { post :create, params: {user: hr_agent_params} }.to change(User, :count).by(1)
      end
    end

    context "Register provider agent" do
      let(:provider_agent_params) { 
        {
          email: "test@example.com",
          password: "password",
          password_confirmation: "password",
          role_id: provider_agent_role.id
        }
      }

      it "should successfully create the user" do
        expect { post :create, params: {user: provider_agent_params} }.to change(User, :count).by(1)
      end
    end

    context "Register site admin hack attempt" do
      let(:site_admin_params) { 
        {
          email: "test@example.com",
          password: "password",
          password_confirmation: "password",
          role_id: site_admin_role.id
        }
      }

      it "should not create the user" do
        expect { post :create, params: {user: site_admin_params} }.to_not change(User, :count)
      end
    end

    context "Register biz admin hack attempt" do
      let(:biz_admin_params) { 
        {
          email: "test@example.com",
          password: "password",
          password_confirmation: "password",
          role_id: biz_admin_role.id
        }
      }

      it "should not create the user" do
        expect { post :create, params: {user: biz_admin_params} }.to_not change(User, :count)
      end
    end
  end
end
