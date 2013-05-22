require 'spec_helper'

describe "Message Pages" do
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "writing a message" do
     describe "with invalid information" do
       pending "should not create a message"
       
       pending "error messages" do
         before { click_button "Send" }
         pending it { should have_content('error') } 
       end
     end
     
    pending "with valid information" do 
       pending "a message should be written"
     end    
  end  
    
  
  describe "message deletion" do
    before { FactoryGirl.create(:message, sender: user1, recipient: user2) }

    describe "as correct user" do
      before { visit root_path }

      pending "should delete a message" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end
  
  
end