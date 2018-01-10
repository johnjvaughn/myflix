require "spec_helper"

describe Category do
  it { should have_many(:videos) }

  describe "#recent_videos" do
    it "returns empty array if no videos in category" do
      comedies = Category.create(name: "Comedies")
      expect(comedies.recent_videos).to eq([])
    end
    it "returns all videos in cat if less than 6 are there" do
      comedies = Category.create(name: "Comedies")
      sp = Video.create(title: "South Park", description: "funny", 
        category: comedies)
      fut = Video.create(title: "Futurama", description: "funny", 
        created_at: 1.day.ago, category: comedies)
      expect(comedies.recent_videos).to eq([sp, fut])
    end
    it "returns all videos in cat if 6 are there" do
      comedies = Category.create(name: "Comedies")
      videos = (1..6).map do |i|
        Video.create(title: "Show #{i}", description: "funny", 
        category: comedies, created_at: i.days.ago)
      end
      expect(comedies.recent_videos).to eq(videos)
    end
    it "returns 6 most recent videos in cat if > 6 are there" do
      dramas = Category.create(name: "Dramas")
      comedies = Category.create(name: "Comedies")
      comedy_videos = (1..9).map do |i|
        j = 10 - i
        Video.create(title: "Show #{i}", description: "funny", 
        category: comedies, created_at: j.days.ago)
      end
      drama_videos = (1..9).map do |i|
        j = 10 - i
        Video.create(title: "Show #{i}", description: "funny", 
        category: dramas, created_at: j.days.ago)
      end
      expect(comedies.recent_videos).to eq(comedy_videos[3..8].reverse)
    end
  end
end