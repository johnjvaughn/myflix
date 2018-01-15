require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :full_name }
  it { should validate_uniqueness_of :email }
  it { should have_many(:queue_items).order(:sort_order) }

  describe "#queued_video?" do
    let(:videos) { [Fabricate(:video), Fabricate(:video)] }
    let(:user) { Fabricate(:user) }
    before do
      Fabricate(:queue_item, user: user, video: videos[0])
    end
    it "returns true if video is in user's queue" do
      expect(user.queued_video?(videos[0])).to be(true)
    end
    it "returns false if video is not in user's queue" do
      expect(user.queued_video?(videos[1])).to be(false)
    end
  end
end