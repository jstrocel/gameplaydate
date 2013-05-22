require 'spec_helper'

describe Invite do
  
  let(:game) { FactoryGirl.create(:game)}
  let(:inviter_user) { FactoryGirl.create(:user) }
  let(:invitee_user) { FactoryGirl.create(:user) }
  let(:invitee) {FactoryGirl.create(:invitee)}
  before {@invite = inviter_user.invites.build(game_id: game.id, fromtime: Time.now+1.weeks, totime: Time.now+1.weeks+1.hours)
    }
  
  
  subject { @invite }
  
  
  it { should respond_to(:invitees) }
  it { should respond_to (:user_id)}
  it { should respond_to (:host)}
  it { should respond_to (:game_id)}
  it { should respond_to (:game)}
  it { should respond_to (:content)}
  it { should respond_to (:invite!)}
  it { should respond_to (:uninvite)}
  it { should respond_to (:invited?)}
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Invite.new(user_id: invitee_user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "when game id is not present" do
    before { @invite.game_id = nil }
    it { should_not be_valid }
  end

  describe "when user id is not present" do
    before { @invite.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "game methods" do
    it { should respond_to(:game_name) }
    its(:game_name) { should == game.name }
  end
  
end
