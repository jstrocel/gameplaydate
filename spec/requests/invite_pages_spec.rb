require 'spec_helper'

describe "Invites" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "Invites Index page" do
    before { visit invites_path }

    it { should have_selector('h1',    text: 'Invites') }
    it { should have_selector('title', text: 'Invites') }
  end
  
  describe "New Invite" do
    before { visit new_invite_path }
    
    
     describe "with invalid information" do
        it "should not create an Invite" do
          expect { click_button "Invite" }.not_to change(Invite, :count)
        end
        
        describe "error messages" do
          before { click_button "Invite" }
          it { should have_selector('title', text: 'New Invite') }
          it { should have_content('error') }
        end  
    end
    
     describe "with valid information" do
        let(:invite) { FactoryGirl.create(:invite) }
        before do
          fill_in "Game name", with: "World of Warcraft"
          fill_in "invite_invitees_attributes_0_user_name",    with: "Tomodachi"
        end
        
        it "should create an invite" do
          expect { click_button "Invite" }.to change(Invite, :count).by(1)
        end
        it "should email all invitees" do
          pending "email all the invitees"
        end  
        
      end
      
      describe "when users are not friends" do
        pending "Should not be valid"
      end  
      
      describe "when destroying an invite" do
       pending "Should delete an invite and all invitee entries"
      end
      
      describe"when accepting an invite" do
        pending "Should change invitee accepted Status to true"
      end
    
  end  
  
  

end