require 'spec_helper'
require 'pp'

describe Event do
  
  let(:game) { FactoryGirl.create(:game)}
  let(:organizer) { FactoryGirl.create(:user) }
  let(:guest) { FactoryGirl.create(:user) }
  let(:invitee) {FactoryGirl.create(:invite)}
  before {@event = organizer.hosted_events.build(game_id: game.id, fromtime: Time.now+1.weeks, totime: Time.now+1.weeks+1.hours)
    }

  
  subject { @event }
  
  
  it { should respond_to(:invites) }
  
  
  it { should respond_to (:organizer)}
  it { should respond_to (:invite!)}
  it { should respond_to (:organizer)}
  it { should respond_to (:game)}
  it { should respond_to (:content)}
  it { should respond_to (:uninvite)}
 
  
  
  it { should be_valid }
  
  pending "accessible attributes" do
    it "should not allow access to organizer_id" do
      expect do
        Event.new(organizer_id: nil)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "when game id is not present" do
    before { @event.game_id = nil }
    it { should_not be_valid }
  end

  describe "when organizer id is not present" do
    before { @event.organizer_id = nil }
    it { should_not be_valid }
  end
  
  describe "game methods" do
    it { should respond_to(:game_name) }
    its(:game_name) { should == game.name }
  end
  
  describe "invite! method" do
    before {
      @event.save
      @event.invite!(guest)
    }
    it "should create a new invitee" do
     @event.invites.has_key?(guest.id).should be_true
    end

  end
  
  

  
end
