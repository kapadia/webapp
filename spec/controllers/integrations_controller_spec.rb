require 'spec_helper'

describe IntegrationsController do

  describe :create do
    describe "when there is no user" do
      it "should create an integration" do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
        lambda {
          post :create
        }.should change(Integration, :count).by(1)
        response.code.should eq('302')
      end
    end

    describe "when there is a user" do
      before :each do
        @user = FactoryGirl.create(:user)
        session[:user_id] = @user.id
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      end

      it "should create a new integration given a refresh token and access token" do
        lambda {
          get :create, access_token: "123456", expires_in: "3920", token_type: "Bearer", refresh_token: "1/xEoDL4iW3cxlI7yDbSRFYNG01kVKM2C-259HOF2aQbI"
          response.should redirect_to(user_home_url)
        }.should change(Integration, :count).by(1)
      end

      describe "when provider_name is google_oauth2" do
        it "should redirect to spreadsheets" do
          lambda {
            get :create, provider: "google_oauth2", access_token: "123456", expires_in: "3920", token_type: "Bearer", refresh_token: "1/xEoDL4iW3cxlI7yDbSRFYNG01kVKM2C-259HOF2aQbI"
            response.should redirect_to(user_home_url)
          }.should change(Integration, :count).by(1)
        end

      end


    end
  end
end
