require 'spec_helper'

describe "beta invitations" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "new" do
    before {visit new_beta_invitation_path}
    
    let(:submit) { "Invite!" }
    describe "with invalid information" do
         it "should not create a new beta invite" do
            expect { click_button submit }.not_to change(BetaInvitation, :count)
          end

          describe "error messages" do
            before { click_button submit }

            it { should have_title('New Beta Invitation') }
            it { should have_content('error') }
          end
    end
    describe "with valid information" do
      before do
        fill_in "Friend's E-mail",        with: "betauser@example.com"
      end
      
      it "should create a Beta Invite" do
         expect { click_button submit }.to change(BetaInvitation, :count).by(1)
       end
      
       it "should send an e-mail" do
          expect { click_button submit }.to change(ActionMailer::Base.deliveries,:size).by(1)
        end
    end
  end
end