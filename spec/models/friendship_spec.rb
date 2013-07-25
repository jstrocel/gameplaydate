require 'spec_helper'

describe Friendship do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:friendship) { follower.friendships.build(followed_id: followed.id) }

  subject { friendship }

  it { should be_valid }

  describe "follower methods" do    
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should eq follower }
    its(:followed) { should eq followed }
  end
  
  
  describe "don't follow twice" do
    before {friendship.save}
    it "should not be able to follow someone twice" do
     expect {  follower.follow!(followed) }.to change(Friendship, :count).by(0)
    end
  end
  describe "when followed id is not present" do
    before { friendship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { friendship.follower_id = nil }
    it { should_not be_valid }
  end
end