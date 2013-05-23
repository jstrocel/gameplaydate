require 'spec_helper'
require 'pp'


describe Invite do
  
  let(:game) { FactoryGirl.create(:game)}
  let(:organizer) { FactoryGirl.create(:user) }
  let(:guest) { FactoryGirl.create(:user) }
  let(:invitee) {FactoryGirl.create(:invitee)}
  before {@invite = organizer.invites.build(game: game, fromtime: Time.now+1.weeks, totime: Time.now+1.weeks+1.hours)
    }
  
  
  subject { @invite }
  
  
  it { should respond_to(:invitees) }
  it { should respond_to (:organizer)}
  it { should respond_to (:invite!)}
  it { should respond_to (:host)}
  it { should respond_to (:game)}
  it { should respond_to (:content)}
  it { should respond_to (:uninvite)}
  it { should respond_to (:users)}
  
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to organizer_id" do
      expect do
        Invite.new(user_id: nil)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "when game id is not present" do
    before { @invite.game_id = nil }
    it { should_not be_valid }
  end

  describe "when organizer id is not present" do
    before { @invite.organizer_id = nil }
    it { should_not be_valid }
  end
  
  describe "game methods" do
    it { should respond_to(:game_name) }
    its(:game_name) { should == game.name }
  end
  
  describe "invite! method" do
    before {
      @invite.save
      @invite.invite!(guest)
      @result = @invite.invitees.where("user_id = ?", guest.id)
    }
    it "should create a new invitee" do
    @result.should_not be_empty
  end
  end

  
end
