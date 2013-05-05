require 'spec_helper'

describe "Static pages" do
  
  subject { page }

  pending "Home page" do
    before { visit root_path }
    
    it { should have_selector('h1',    text: 'GamePlayDate') }
    it { should have_selector('invites-upcoming')}
    it { should have_selector('invites-pending')}
    it { should have_selector('invites-past')}
    describe "for signed in users" do
     pending "should list the new invites that haven't been RSVP'd" 
     pending "should list new friend requests"      
     pending "should list schedule" 
      
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
