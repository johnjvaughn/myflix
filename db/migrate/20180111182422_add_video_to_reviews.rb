class AddVideoToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :video, foreign_key: true
  end
end
