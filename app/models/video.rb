class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
    
  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    where("title ILIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end