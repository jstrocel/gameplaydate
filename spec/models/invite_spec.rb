require 'spec_helper'

describe Invite do
 
  
  let(:game) { FactoryGirl.create(:game)}
  let(:organizer) { FactoryGirl.create(:user) }
  let(:guest) { FactoryGirl.create(:user) }
  before do
    @event = organizer.hosted_events.build(game: game, fromtime: 2.hours.from_now, totime: 3.hours.from_now)
    @event.save
    @invite = @event.invites.build(user: guest)
  end

  subject {@invite}

  it { should respond_to(:event) }
  it { should respond_to(:user) }
  it { should respond_to(:status) }
  it { should respond_to(:send_email) }
  
  it "should notify the user through email" do
   lambda {@invite.save}.should change(ActionMailer::Base.deliveries,:size).by(1)
  end
  
  describe "when the user has been invited already" do
    before{@event.invite!(guest)}
    it { should_not be_valid}
  end
  
  
end