module ReviewsHelper
  def display_rating(review)
    "Rating: #{review.rating} / 5"
  end
end
