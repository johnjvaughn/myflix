class VideosController < ApplicationController
  layout "application"

  def index
    @categories = Category.all
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end
end
