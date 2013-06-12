require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }
    
    it { should have_selector('h1',    text: 'GamePlayDate') }
  
    describe "for signed in users" do
     let(:user) { FactoryGirl.create(:user, :with_events) }  
     before{
       sign_in user
       visit root_path
     }  
     
       
       it { should have_selector('.invites-pending')}
       it { should have_selector('.friend-requests')}
       it { should have_selector('.events-upcoming')}
       
       it "should list the new invites that haven't been RSVP'd"  do
         
         user.pending_invites.each do |item|
           page.should have_selector("li##{item.id}", text: item.fromtime)
         end
       end
       
       pending "should list new friend requests"  do
         
          user.requests.each do |item|
            page.should have_selector("li##{item.id}", text: item.user.name)
          end
       end
       
       it "should list schedule"  do
         
           user.invites.each do |item|
             page.should have_selector("li##{item.id}", text: item.fromtime)
           end
        end
    end
  end
  
  pending "should have the right links on the layout" do
    visit root_path
    click_link "Messages"
    page.should have_selector 'title', text: full_title('Messages')
    click_link "Schedule"
    page.should have_selector 'title', text: full_title('Schedule')
    click_link "Profile"
    page.should have_selector 'title', text: full_title('Profile')
    click_link "Home"
    page.should have_selector 'title', text: full_title('Home')
    click_link "Sign up"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "GamePlayDate"
    page.should have_selector 'h1', text: 'GamePlayDate'
  end
  
  
  
end
