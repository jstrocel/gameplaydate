require 'spec_helper'

describe "events", :js => true do
   self.use_transactional_fixtures = false
  subject { page }
  let(:game) { FactoryGirl.create(:game)}
  let(:invitee1) {FactoryGirl.create(:user)}
  let(:invitee2) {FactoryGirl.create(:user)}
  let(:organizer) { FactoryGirl.create(:user) }
  let (:event) {FactoryGirl.create(:event, organizer: organizer, game: game, fromtime: 2.hours.from_now, totime: 3.hours.from_now)} 
     
  
  before { 
    organizer.claim_game!(game)
    invitee1.follow!(organizer)
    invitee2.follow!(organizer)
    event.invite!(invitee1)
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
   
   describe "create new invite form", :js => true  do
     
     before do
       
       click_link "Add Invite" 
     end
    it {should have_selector(".invite")}
   end
   
   
 
     describe "with valid information" do
       
        before do
         
          click_link "Add Invite"
          
          @invitebox1 = page.find('#invite-fields').first(".invitee")[:id]
          select invitee1.name, :from=> @invitebox1
         
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
        
        it "should send an email" do
           expect do
              click_button "Create Event"
            end.to change(ActionMailer::Base.deliveries,:size).by(1)
        end
      end
    
  end  
  
  describe "My Events", :js =>false do
     let(:event_hoster) { FactoryGirl.create(:user, :with_events) }  
     before do
       sign_in event_hoster
       visit my_events_path
     end
     
     it "should display the user's hosted events" do
         event_hoster.events.limit(5).each do |item|
             expect(page).to have_selector("li##{item.id}", text: item.game.name)
           end  
    end     
         
     
     
    DatabaseCleaner.clean
  end
  
  
  describe "Edit" do

    context "As Organizer" do
      before do
        sign_in organizer
        visit edit_event_path(event)
      end

      context "no new information" do

        describe "should not have errors" do
          before { 
          click_button "Create Event" 
          }

          it { should_not have_content('error') }
        end

        it "should not create new invites" do
         expect {click_button "Create Event"}.to change(Invite, :count).by(0)
        end
      end # No New Information
      context "adding an invitee" do
        before do
          if !page.has_selector?('.invitee') 
            click_link "Add Invite" 
          end
          @invitebox2 = page.all('.invitee').last[:id]
          select invitee2.name, :from=> @invitebox2
          
        end
        it "should create a new invite" do
          expect do
            click_button "Create Event"
            sleep(30)
          end.to change(Invite, :count).by(1)
        end
      end #Adding an Invitee
      context "removing at invitee" do
        before do
          
          
          within page.all('.invite').last do click_link "remove" end
          
        end

        it "should delete an invite" do
          expect do
           click_button "Create Event"
          end.to change(Invite, :count).by(-1)
        end
      end
    end # As Organizer
  end # Edit

  
  
  
  describe "Show Event", :js => false do
    
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
          within("div##{@invite.id}.rsvp"){ click_button "Accept" }
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