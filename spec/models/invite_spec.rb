require 'spec_helper'

describe Invite do
  let(:game) { FactoryGirl.create(:game)}
  let(:organizer) { FactoryGirl.create(:user) }
  let(:organizer2) { FactoryGirl.create(:user) }
  let(:guest) { FactoryGirl.create(:user) }
  let (:event1){ organizer.hosted_events.build(game: game, fromtime: 2.hours.from_now, totime: 3.hours.from_now)}
  let (:event2){ organizer2.hosted_events.build(game: game, fromtime: event1.fromtime, totime: event1.totime)}
 
  
  subject {Invite.new}
  
    describe "validations" do
    
      context "should not be able invite a player with a conflicting event" do
        before{
          event2.save
          event2.invite!(guest)
          event1.save
        }
        let (:event) {:event1}
        let (:user) {:guest}
        it{should_not be_valid }
        
      end
    
      context "should not be able to invite the organizer" do
        let(:user) {:organizer}
        it{should_not be_valid }
      
      end
    
    end
  
end