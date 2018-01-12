module ReviewsHelper
  def display_rating(review)
    "Rating: #{review.rating} / 5"
  end

  def rating_options
    [["5 Stars", 5], ["4 Stars", 4], ["3 Stars", 3], ["2 Stars", 2], ["1 Star", 1]]
  end
end
