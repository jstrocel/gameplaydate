require 'spec_helper'

describe "Activity Feed pages" do
  let (:admin_user) {FactoryGirl.create(:admin)}
  let (:friend_requester) {FactoryGirl.create(:user)}
  let (:friend_accepter) {FactoryGirl.create(:user)}
  let (:game) {FactoryGirl.create(:game)}
  subject { page }


  describe "index" do

     before do
      sign_in friend_requester
      visit user_path(friend_accepter)
      click_button "Add Friend"
      click_link "Sign out"
      sign_in friend_accepter
      visit friend_requests_user_path(friend_accepter)
      visit game_path(game)
      click_button "Claim"
      click_link "Sign out"
      sign_in admin_user
      visit activities_path
     end
     
     it { should have_selector('h1',    text: 'Activity Feed') }
     
     it "should have users as friends" do
       friend_requester.friends_with?(friend_accepter).should be_true
        friend_accepter.friends_with?(friend_requester).should be_true
     end
     
      it { should have_selector('.activity') }

     
     

   end

end