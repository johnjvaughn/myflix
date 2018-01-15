class VideosController < ApplicationController
  before_action :require_user
  layout "application"

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @review = Review.new
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title(params[:search_term].strip)
  end
end
