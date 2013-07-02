require 'spec_helper'

describe "Personas" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "new" do
    before {visit new_persona_path}
    
    let(:submit) { "Add Persona" }
    describe "with invalid information" do
         it "should not create a new Persona" do
            expect { click_button submit }.not_to change(user.personas, :count)
          end

          describe "error messages" do
            before { click_button submit }

            it { should have_title('New Persona') }
            it { should have_content('error') }
          end
    end
    describe "with valid information" do
      before do
        fill_in "Game",            with: "World of Warcraft"
        fill_in "Character Name",  with: "Barlaick"
        fill_in "Server_Region",   with: "Misha"
      end
      
      it "should create a Persona" do
         expect { click_button submit }.to change(user.personas, :count).by(1)
       end
    end
  end
  
  describe "delete" do
    before { FactoryGirl.create(:persona, user: user) }
    
    describe "as correct user" do
      before { visit edit_user_path }
      
      it "should delete a persona" do
        expect { click_link "delete" }.to change(Persona, :count).by(-1)
      end
    end
  end
  
  
end