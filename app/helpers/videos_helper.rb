module VideosHelper
  def average_rating(video)
    count = video.reviews.count
    return "No ratings yet" if count == 0
    total = video.reviews.sum {|review| review.rating }
    avg = (1.0 * total / count).round(1)
    "Rating: #{avg}/5.0"
  end
end
