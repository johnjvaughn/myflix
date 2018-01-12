require "spec_helper"

describe ReviewsController do
  describe "POST create" do
    context "authentic user with valid info" do
      let(:vid) { Fabricate(:video) }  
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        post :create, params: { review: Fabricate.attributes_for(:review, video: vid) }
      end

      it "saves the review" do
        expect(Review.count).to eq(1)
      end
      it "associates the review with the video" do
        expect(Review.first.video).to eq(vid)
      end
      it "associates the review with the user" do
        expect(Review.first.user).to eq(current_user)
      end
      it "writes an notice" do
        expect(flash[:notice]).to_not be_blank
      end
      it "does not write an error" do
        expect(flash[:error]).to be_blank
      end
      it "redirects to same video page" do
        expect(response).to redirect_to video_path(vid)
      end
    end

    context "authentic user with invalid info" do
      let(:vid) { Fabricate(:video) }  
      let(:existing_review) { Fabricate(:review, video_id: vid.id) }
      before do
        existing_review.save
        session[:user_id] = Fabricate(:user).id
        post :create, params: { review: { rating: 5, video_id: vid.id } }
      end

      it "does not save the review" do
        expect(Review.count).to eq(1)
      end
      it "writes an error" do
        expect(flash[:error]).to_not be_blank
      end
      it "sets @video" do
        expect(assigns(:video)).to eq(vid)
      end
      it "sets @reviews" do
        expect(assigns(:reviews)).to eq([existing_review])
      end
      it "redirects to same video page" do
        expect(response).to render_template "videos/show"
      end
    end

    context "inauthenticated user" do
      let(:vid) { Fabricate(:video) }  
      it "redirects to sign_in page" do
        session[:user_id] = nil
        post :create, params: { review: Fabricate.attributes_for(:review, video: vid) }
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end