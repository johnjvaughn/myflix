class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }  
  has_many :queue_items, -> { order(:sort_order) }
  
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  
  has_secure_password

  def normalize_queue_item_order
    queue_items.each_with_index do |qi, index|
      unless qi.sort_order == index + 1
        qi.update_column(:sort_order, index + 1)
      end
    end
  end

  def update_sort_orders(new_sort_orders)
    QueueItem.transaction do
      new_sort_orders.each do |sort_item|
        queue_item = queue_items.find_by_id(sort_item[:id])
        sort_order = sort_item[:sort_order].to_i
        if queue_item && queue_item.sort_order != sort_order
          queue_item.update_column(:sort_order, sort_order)
        end
      end
    end
    normalize_queue_item_order
  end

  def update_ratings(new_ratings)
    Review.transaction do
      new_ratings.each do |rating_item|
        queue_item = queue_items.find_by_id(rating_item[:id])
        queue_item.rating = rating_item[:rating].to_i if queue_item
      end
    end
  end

  def queued_video?(video)
    queue_items.map(&:video_id).include?(video.id)
  end
end