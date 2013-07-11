require 'spec_helper'

describe "Games" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  let (:game) { FactoryGirl.create(:game)}
  
  before { sign_in user }
  
  describe "show page" do

    before { visit game_path(game) }

    it { should have_content(game.name) }
    it { should have_title(game.name) }

    describe "Owned/Un-Own" do
      before { sign_in user }
      
      describe "Claiming a game" do
        before { visit game_path(game) }

        it "should increment the user's games owned count" do
          expect do
            click_button "Claim"
          end.to change(user.games, :count).by(1)
        end

        it "should increment the game's users count" do
          expect do
            click_button "Claim"
          end.to change(game.users, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Claim" }
          it { should have_xpath("//input[@value='UnClaim']") }
        end
      end

      describe "unclaiming a game" do
        before do
          user.claim_game!(game)
          visit game_path(game)
        end

        it "should decrement the user's games owned count" do
          expect do
            click_button "UnClaim"
          end.to change(user.games, :count).by(-1)
        end

        it "should decrement the the game's users count" do
          expect do
            click_button "UnClaim"
          end.to change(game.users, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "UnClaim" }
          it { should have_xpath("//input[@value='Claim']") }
        end
      end
    end
  end
end