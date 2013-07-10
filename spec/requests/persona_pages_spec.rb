require 'spec_helper'

describe "Personas" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  let (:game) { FactoryGirl.create(:game)}
  before do
    sign_in user 
    user.claim_game!(game)
  end
  
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
        select game.name,            :from=> "persona[game_id]"
        fill_in "Character Name",  with: "Barlaick"
        fill_in "Server Name",   with: "Misha"
      end
      
      it "should create a Persona" do
         expect { click_button submit }.to change(user.personas, :count).by(1)
       end
    end
  end
  
  describe "delete" do
    before { @persona =FactoryGirl.create(:persona, user: user, game: game) }
    
    describe "as correct user" do
      before { visit persona_path(@persona) }
      
      it "should delete a persona" do
        expect { click_link "Delete" }.to change(Persona, :count).by(-1)
      end
    end
  end
  
  
end