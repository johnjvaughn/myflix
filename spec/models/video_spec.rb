require "spec_helper"

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an array of one video for a perfect match" do
      fut = Video.create(title: "Futurama", description: "funny tv show")
      fg = Video.create(title: "Family Guy", description: "funny tv show")
      expect(Video.search_by_title("family guy")).to eq([fg])
    end  
    it "returns an array of one video for a partial match" do
      fg = Video.create(title: "Family Guy", description: "funny tv show")
      fut = Video.create(title: "Futurama", description: "funny tv show")
      expect(Video.search_by_title("mily")).to eq([fg])
    end
    it "returns empty if no match" do
      fg = Video.create(title: "Family Guy", description: "funny tv show")
      fut = Video.create(title: "Futurama", description: "funny tv show")
      expect(Video.search_by_title("families")).to eq([])
    end
    it "returns multiple videos if more than one match" do
      bttf = Video.create(title: "Back to the Future", description: "funny tv show", created_at: 1.day.ago)
      fw = Video.create(title: "Future War", description: "bad movie")
      fut = Video.create(title: "Futurama", description: "cartoon")
      expect(Video.search_by_title("future")).to eq([fw, bttf])
    end
  end
end