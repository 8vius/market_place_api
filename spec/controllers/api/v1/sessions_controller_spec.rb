require 'spec_helper'

describe Api::V1::SessionsController do
  render_views

  describe "POST #create" do
    before(:each) do
      @user = create(:user)
    end

    context "when the credentials are correct" do
      before(:each) do
        credentials = { email: @user.email, password: "12345678" }
        post :create, { session: credentials }
      end

      it "returns the authenticated user that corresponds to the credentials" do
        @user.reload
        expect(json_response[:session][:auth_token]).to eq @user.auth_token
      end

      it { should respond_with 200 }
    end

    context "when the credentials are incorrect" do
      before(:each) do
        credentials = { email: @user.email, password: "invalid" }
        post :create, { session: credentials }
      end

      it "renders the json errors as to why authentication failed" do
        expect(json_response[:errors]).to eq "Invalid email or password"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create(:user)
      sign_in @user
      delete :destroy, id: @user.auth_token
    end

    it { should respond_with 204 }
  end
end
