require 'spec_helper'

describe Friendship do
  let(:friend1) { FactoryGirl.create(:user) }
  let(:friend2) { FactoryGirl.create(:user) }
  let(:relationship) { friend1.friendships.build(followed_id: friend2.id) }

  subject { relationship }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        Friendship.new(follower_id: friend1.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should == friend1 }
    its(:followed) { should == friend2 }
  end
  
  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end
  
  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
  
end
