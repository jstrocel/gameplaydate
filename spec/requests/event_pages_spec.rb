require 'spec_helper'

describe "events" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
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
        #let(:Event) { FactoryGirl.create(:Event) }
        let(:game) { FactoryGirl.create(:game)}
        let(:invitee) {FactoryGirl.create(:user)}
        before do
          fill_in "Game name", with: game.name
          fill_in "event_invites_attributes_0_user_name",    with: invitee.name
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
        
        pending "should not be able to invite the organizer" do
        fill_in "event_invites_attributes_0_user_name",    with: current_user.name
          expect do
            click_button "Create Event"
          end.to change(Event, :count).by(0)
        end
      end
      

      
      
      
      
      
      
      describe "when users are not friends" do
        pending "Should not be valid"
      end  
      
      describe "when destroying an Event" do
       pending "Should delete an Event and all invite entries"
      end
      
      describe"when accepting an Event" do
        pending "Should change invite accepted Status to true"
      end
    
  end  
  
  

end