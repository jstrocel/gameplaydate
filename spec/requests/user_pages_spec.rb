require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end
    
      it { should have_selector('title', text: 'All users') }
  end
end