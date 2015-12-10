require 'spec_helper'

describe Api::V1::UsersController do
  describe "GET #show" do
    before(:each) do
      @user = create(:user)
      get :show, id: @user.id
    end

    it "returns the information about a reporter on a hash" do
      user_response = json_response
      expect(user_response[:email]).to eq @user.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @user_attributes = attributes_for :user
        post :create, { user: @user_attributes }
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eq @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "with invalid attributes" do
      before(:each) do
        @invalid_user_attributes = {
          password: "123456578",
          password_confirmation: "12345678"
        }

        post :create, { user: @invalid_user_attributes }
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PATCH #update" do
    context "when successfully updated" do
      before(:each) do
        @user = create(:user)
        api_authorization_header(@user.auth_token)
        patch :update, { id: @user.id, user: { email: 'newmail@example.com' } }
      end

      it "renders a json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eq 'newmail@example.com'
      end

      it { should respond_with 200 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create(:user)
        api_authorization_header(@user.auth_token)
      delete :destroy, { id: @user.auth_token }
    end

    it { should respond_with 204 }
  end
end
