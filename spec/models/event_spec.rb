require 'spec_helper'
require 'pp'

describe Event do
  
  let(:game) { FactoryGirl.create(:game)}
  let(:organizer) { FactoryGirl.create(:user) }
  let(:guest) { FactoryGirl.create(:user) }
  let(:invitee) {FactoryGirl.create(:invite)}
  before {
    params = {event: { game: game, fromtime: 2.hours.from_now, totime: 3.hours.from_now}}
    @event = Event.new(params[:event])
  }

  
  subject { @event }
  
  
  it { should respond_to(:invites) }
  it { should respond_to (:organizer)}
  it { should respond_to (:invite!)}
  it { should respond_to (:game)}
  it { should respond_to (:content)}
  it { should respond_to (:uninvite)}
 
  
  
  it { should be_valid }
  
  
  describe "when game id is not present" do
    before { @event.game_id = nil }
    it { should_not be_valid }
  end

  
  describe "game methods" do
    it { should respond_to(:game_name) }
    its(:game_name) { should == game.name }
  end
  
  describe "invite! method" do
    before { @event.save! }
    it "should create a new invitee" do
     
      expect do
        @event.invite!(guest)
     end.to change(@event.invites, :count).by(1)
    end

  end
  
  pending "should have an organizer" do
    before {@event.invites = nil}
    it { should_not be_valid }
  end

  
end
