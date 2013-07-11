require 'spec_helper'

describe GameOwnership do
  pending "add some examples to (or delete) #{__FILE__}"
  
  let(:game_owner) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game) }
  let(:game_ownership) { game_owner.gameownerships.build(game_id: game.id) }

  subject { game_ownership }
 
  it { should be_valid }

  describe "follower methods" do    
    it { should respond_to(:game) }
    it { should respond_to(:user) }
    its(:game) { should eq game }
    its(:user) { should eq game_owner }
  end

  describe "when game id is not present" do
    before { game_ownership.game_id = nil }
    it { should_not be_valid }
  end

  describe "when user id is not present" do
    before { game_ownership.user_id = nil }
    it { should_not be_valid }
  end
  
  
  
end
