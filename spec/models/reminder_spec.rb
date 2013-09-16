require 'spec_helper'

describe Reminder do
  let(:game) { FactoryGirl.create(:game)}
  let(:organizer) { FactoryGirl.create(:user) }
  let(:invitee1) { FactoryGirl.create(:user) }
  let(:invitee2) { FactoryGirl.create(:user) }
  before do
    @event = organizer.hosted_events.build(game: game, fromtime: 2.hours.from_now, totime: 3.hours.from_now)
    @event.save
    @event.invite!(invitee1)
    @event.invite!(invitee2)
    @reminder = @event.reminders.build(send_time:5.days.from_now)
  end
  
  subject {@reminder}

   it { should respond_to(:event) }
   
   it { should respond_to(:send_time) }


   it "should notify the user through email" do
    lambda {@reminder.save}.should change(ActionMailer::Base.deliveries,:size).by(3)
   end
  
end
