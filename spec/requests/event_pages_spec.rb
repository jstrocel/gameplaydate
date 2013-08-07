require 'spec_helper'

describe "events" do
  
  subject { page }
  let(:game) { FactoryGirl.create(:game)}
  let(:invitee1) {FactoryGirl.create(:user)}
  let(:invitee2) {FactoryGirl.create(:user)}
  let(:organizer) { FactoryGirl.create(:user) }
  let (:event) {FactoryGirl.create(:event, organizer: organizer, game: game, fromtime: 2.hours.from_now, totime: 3.hours.from_now)} 
     
  
  before { 
    organizer.claim_game!(game)
    invitee1.follow!(organizer)
    }
  
  describe "Events Index page" do
    before do
      sign_in organizer 
      visit events_path 
    end
    

    it { should have_selector('h1',    text: 'Events') }
    it { should have_title('Events') }
  end
  
  describe "New Event" do
    before do
      sign_in organizer 
      visit new_event_path 
    end
    
    
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
          select invitee1.name, :from=> "event[invites_attributes][0][user_id]"
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
  
  describe "Show Event" do
    before do
         event.invite!(invitee1)
         event.invite!(invitee2)
    end
    
    context "As Organizer" do
      before do
        sign_in organizer
        visit event_path(event)
      end
    end
    
    
    context "As Invitee" do 
      before do  
        sign_in invitee1
        visit event_path(event)
    
        @invite = Invite.find_by(event:event, user:invitee1)
        
      end
      
      
      it { should have_selector("li##{@invite.id}") }
      
      it "should be able to accept invite" do
        expect do
          within("div#1.rsvp"){ click_button "Accept" }
           end.to change(event.invites.accepted, :count).by(1)
      end
      
      context "after the invitee has accepted the invitation" do
        before do
          invitee1.accept_invite!(event)
           visit event_path(event)
        end
        
        it "should be able to cancel invite" do
          expect do
               click_button "Cancel"
             end.to change(event.invites.cancelled, :count).by(1)
        end
      end
      
    end
    
  end
  
  
  
end