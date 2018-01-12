require "spec_helper"

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid info" do
      before do
        post :create, params: { user: Fabricate.attributes_for(:user) }
      end
      it "saves the user's information" do
        expect(User.count).to eq(1)
      end
      it "redirects the user to the sign in page" do
        expect(response).to redirect_to sign_in_path        
      end
    end

    context "with invalid info" do
      before do
        post :create, params: { 
          user: { password: "password", full_name: "Joe Test" } }
      end
      it "does not save the user's information" do
        expect(User.count).to eq(0)
      end
      it "renders the new user page" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)        
      end
    end    
  end

end