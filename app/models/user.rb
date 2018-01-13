class User < ActiveRecord::Base
  has_many :reviews, -> { order(:created_at, :desc) }  
  has_many :queue_items, -> { order(:sort_order) }
  
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  
  has_secure_password
end