require "spec_helper"

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "Star Wars")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("Star Wars")
    end  
  end

  describe "#rating" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }
    
    it "returns the user's rating of the associated video" do
      review = Fabricate(:review, user: user, video: video, rating: 4)
      expect(queue_item.rating).to eq(4)
    end

    it "returns nil when the user has not rated the associated video" do
      user2 = Fabricate(:user)
      review = Fabricate(:review, user: user2, video: video)
      expect(queue_item.rating).to be_nil
    end
  end

  describe "#category_name" do
    it "return's the associated video's category name" do
      category = Category.new(name: "Sci-Fi")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("Sci-Fi")
    end
  end

  describe "#category" do
    it "return's the associated video's category" do
      category = Category.new(name: "Sci-Fi")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end

end