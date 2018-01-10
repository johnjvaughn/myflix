class Category < ActiveRecord::Base
  has_many :videos, -> { order(:title) }
  
  validates :name, presence: true

  def recent_videos
    videos.sort_by{|v| v.created_at}.reverse.first(6)
  end
end