require 'spec_helper'

describe "events" do
  
  subject { page }
   let(:game) { FactoryGirl.create(:game)}
    let(:invitee) {FactoryGirl.create(:user)}
  let(:organizer) { FactoryGirl.create(:user) }
  before { 
    organizer.claim_game!(game)
    invitee.follow!(organizer)
    sign_in organizer 
    }
  
  describe "Events Index page" do
    before { visit events_path }

    it { should have_selector('h1',    text: 'Events') }
    it { should have_title('Events') }
  end
  
  describe "New Event" do
    before { visit new_event_path }
    
    
     describe "with invalid information" do
        it "should not create an Event" do
          expect { click_button "Create Event" }.not_to change(Event, :count)
        end
        
        describe "error messages" do
          before { click_button "Create Event" }
          it { should have_title('New Event') }
          it { should have_content('error') }
        end  
    end
    
     describe "with valid information" do
       
        before do
          select invitee.name, :from=> "event[invites_attributes][0][user_id]"
          select game.name, :from=> "event[game_id]"
        end
        
        it "should create an Event" do
          expect do
            click_button "Create Event"
          end.to change(Event, :count).by(1)
        end
        
        it "should create an Invite" do
           expect do
              click_button "Create Event"
            end.to change(Invite, :count).by(1)
        end
      end
    
  end  
  
end