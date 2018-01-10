require "spec_helper"

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  # it "belongs to category" do
  #   dramas = Category.create(name: "dramas")
  #   casa = Video.create(title: "Casablanca", description: "starring Humphrey Bogart", 
  #          category: dramas)
  #   expect(casa.category).to eq(dramas)
  # end

  # it "requires title to save" do
  #   video = Video.create(description: "a great video")
  #   expect(Video.count).to eq(0)
  # end

  # it "requires description to save" do
  #   video = Video.create(title: "video title")
  #   expect(Video.count).to eq(0)
  # end
end