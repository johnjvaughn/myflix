class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_numericality_of :sort_order, {only_integer: true}

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).last
    review.rating if review
  end

  def category_name
    category.name
  end

end