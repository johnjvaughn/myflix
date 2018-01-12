class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "Review submitted."
      redirect_to @review.video
    else
      flash[:error] = "Review could not be saved."
      @video = @review.video
      @reviews = @video.reviews.reload.sort_by{|review| review.created_at}.reverse
      render "/videos/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :video_id)
      .merge({user_id: session[:user_id]})
  end
end
