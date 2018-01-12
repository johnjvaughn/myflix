require "spec_helper"

describe SessionsController do
  describe "GET new" do
    it "redirects to home if already logged in" do
      bill = Fabricate(:user)
      session[:user_id] = bill.id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    let(:bob) { Fabricate(:user) }
    context "with valid info" do
      before do
        post :create, params: {
          email: bob.email, password: bob.password }
      end
      it "sets the session id" do
        expect(session[:user_id]).to eq(bob.id)
      end
      it "redirects to home page" do
        expect(response).to redirect_to home_path        
      end
      it "sets notice" do
        expect(flash[:notice]).not_to be_blank
      end
      it "sets no error" do
        expect(flash[:error]).to be_blank
      end
    end

    context "with invalid info" do
      before do
        post :create, params: {
          email: bob.email, password: "bad" + bob.password }
      end
      it "does not set the session id" do
        expect(session[:user_id]).to be_blank
      end
      it "redirects to sign_in page" do
        expect(response).to redirect_to sign_in_path
      end
      it "sets error message" do
        expect(flash[:error]).not_to be_blank
      end
    end    
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it "sets the session id to nil" do
      expect(session[:user_id]).to be_blank
    end
    it "redirects to home path" do
      expect(response).to redirect_to root_path
    end
    it "sets notice" do
      expect(flash[:notice]).not_to be_blank
    end      
  end

end
