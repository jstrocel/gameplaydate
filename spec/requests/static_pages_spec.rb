require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'GamePlayDate'" do
      visit '/static_pages/home'
      page.should have_content('GamePlayDate')
    end
  end
end
