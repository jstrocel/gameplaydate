require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }
    
    it { should have_selector('h1',    text: 'Welcome to GamePlaydate!') }
    
    
    
    describe "for signed in users" do
     let(:user) { FactoryGirl.create(:user, :with_events) }  
     let(:friend_requester) { FactoryGirl.create(:user, :with_events) } 
     before{
       friend_requester.follow!(user)
       sign_in user
       
       visit root_path
     }  
     
     it "should display the user's schedule" do
        user.pending_invites.limit(5).each do |item|
           expect(page).to have_selector("li##{item.id}", text: item.game.name)
         end
        
        user.confirmed_events.limit(5).each do |item|
              expect(page).to have_selector("li##{item.id}", text: item.game.name)
        end
         
     end
     
     it"should display the user's friend requests" do
      expect(page).to have_selector(".friend_requests_number", text: user.friend_requests.count )
    end
     
     
    
      
    end
  end
  
  
  
end
