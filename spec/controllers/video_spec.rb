require "spec_helper"

describe VideosController do

  describe "GET show" do
    let(:video) { Fabricate(:video) }
    it "sets the @video variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :show, params: { id: video.id }
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, params: { id: video.id }
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "redirects the unauthenticated user to the sign in page" do
      get :show, params: { id: video.id }
      expect(response).to redirect_to sign_in_path        
    end
  end

  describe "GET search" do
    it "sets the @videos variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      fut = Fabricate(:video, title: "Futurama")
      get :search, params: { search_term: "rama" }
      expect(assigns(:videos)).to eq([fut])
    end

    it "redirects the unauthenticated user to the sign in page" do
      fut = Fabricate(:video, title: "Futurama")
      get :search, params: { search_term: "rama" }
      expect(response).to redirect_to sign_in_path        
    end
  end
end