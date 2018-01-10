require "spec_helper"

describe Category do
  it { should have_many(:videos) }

  # it "has many videos" do
  #   comedies = Category.create(name: "Comedies")
  #   south_park = Video.create(title: "South Park", description: "funny", category: comedies)
  #   futurama = Video.create(title: "Futurama", description: "funny", category: comedies)
  #   expect(comedies.videos).to eq([futurama, south_park])
  # end
end