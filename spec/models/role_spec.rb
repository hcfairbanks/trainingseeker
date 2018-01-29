require 'rails_helper'

RSpec.describe User, type: :model do

  it "create a role with valid attributes" do
    test_role = Role.create(name: "user")
    expect(test_role).to be_valid
  end

  it "create a role with invalid attributes" do
    test_role = Role.create(name: "")
    expect(test_role).to be_invalid
  end

  it "update a role" do
    test_role = Role.create(name: "tester")
    test_role.update(name: "QA")
    expect(test_role).to be_valid
  end

  it "update a role with invalid params" do
    test_role = Role.create(name: "clerk")
    test_role.update(name:"")
    expect(test_role).to be_invalid
  end

  describe "delete a role" do

    it "role decreased by 1" do
      test_role = Role.create(name: "clerk")
      expect {Role.destroy(test_role.id)}.to change(Role, :count).by(-1)
    end

    it "role cant be found in db" do
      test_role = Role.create(name: "manager")
      Role.destroy(test_role.id)
      expect(Role.where(id: test_role.id).count).to eq(0)
    end

  end

end
