class QueueItemsController < ApplicationController
  before_action :require_user
  layout "application"

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    if video_in_user_queue?(video)
      flash[:error] = "This video is already in your queue."
    else
      new_sort_order = current_user.queue_items.count + 1
      QueueItem.create(video: video, user: current_user, sort_order: new_sort_order)
    end
    redirect_to queue_items_path, notice: "Video was added to your queue."
  end

  def destroy
    qi = QueueItem.find(params[:id])
    if qi && current_user.queue_items.include?(qi)
      qi.destroy
      reorder_items
      flash[:notice] = "Video was removed from your queue."
    end 
    redirect_to queue_items_path
  end

  private

  def video_in_user_queue?(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def reorder_items
    current_user.queue_items.each_with_index do |qi, index|
      qi.sort_order = index + 1
      qi.save
    end
  end

end
