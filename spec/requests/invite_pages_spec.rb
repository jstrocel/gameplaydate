require 'spec_helper'

describe "Invites" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "Invites page" do
    before { visit invites_path }

    it { should have_selector('h1',    text: 'Invites') }
    it { should have_selector('title', text: 'Invites') }
  end
  
  describe "New Invite" do
    before { visit invites_path }
    
    
     describe "with invalid information" do
        it "should not create an Invite" do
          expect { click_button "Invite" }.not_to change(Invite, :count)
        end
        
        describe "error messages" do
          before { click_button "Invite" }
          it { should have_selector('title', text: 'Invites') }
          it { should have_content('error') }
        end  
    end
    
     describe "with valid information" do
        let(:invite) { FactoryGirl.create(:invite) }
        before do
          fill_in "Game name", with: "World of Warcraft"
          fill_in "Invitee",    with: "Tomodachi"
          click_button "Invite"
        end
        
        it "should create an invite" do
          expect { click_button "Invite" }.to change(Invite, :count).by(1)
        end
        
      end
    
  end  

end