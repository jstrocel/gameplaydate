require 'spec_helper'

describe "User pages", :focus => :true do

  subject { page }
 
 describe "index" do
   
   before do
     sign_in FactoryGirl.create(:user)
     FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
     FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
     visit users_path
   end

   it { should have_title('All Users') }
   
   
    describe "pagination" do

       before(:all) { 30.times { FactoryGirl.create(:user) } }
       after(:all)  { User.delete_all }

       it { should have_selector('div.pagination') }

       it "should list each user" do
         User.paginate(page: 1).each do |user|
           expect(page).to have_selector('li', text: user.name)
         end
       end
     end

     describe "delete links" do

       it { should_not have_link('delete') }

       describe "as an admin user" do
         let(:admin) { FactoryGirl.create(:admin) }
         before do
           sign_in admin
           visit users_path
         end

         it { should have_link('delete', href: user_path(User.first)) }
         it "should be able to delete another user" do
           expect { click_link('delete', href: user_path(User.first)) }.to change(User, :count).by(-1)
         end
         it { should_not have_link('delete', href: user_path(admin)) }
       end
     end
   end

 describe "profile page" do
  let(:user) { FactoryGirl.create(:user) }
   before {sign_in user
      visit user_path(user) }

   it { should have_selector('h1',    text: user.name) }
   it { should have_title(user.name) }
 end
 
 describe "reset password" do
    before { visit signup_path }
   
 end
 
 describe "signup page" do
    before { 
      
      visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before {
      CONFIG[:beta_mode] = false
      visit signup_path}

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "error messages" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
       it "should generate an activity feed entry" do
          expect { click_button submit }.to change(Activity, :count).by(1)
        end

      describe "after saving the user" do
        before { click_button submit }
        
        let(:user) { User.find_by(email:'user@example.com') }

        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end
  
  
  describe "beta signup" do

    before do
      @sender = FactoryGirl.create(:user)
      @beta_invitation = FactoryGirl.create(:beta_invitation, sender: @sender)
      CONFIG[:beta_mode] = true
      visit beta_signup_path(@beta_invitation.token)
    end
    
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "error messages" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
    end
      describe "with valid information" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",        with: @beta_invitation.recipient_email
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end

        it "should create a user" do
          expect {
             click_button submit }.to change(User, :count).by(1)
        end

        describe "after saving the user" do
          before { click_button submit }

          let(:user) { User.find_by(email:@beta_invitation.recipient_email) }

          it { should have_selector('div.alert.alert-success', text: 'Welcome') }
          it { should have_link('Sign out') }
        end
      end   
  end
  
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
   let(:game) { FactoryGirl.create(:game) }
    let!(:p1) { FactoryGirl.create(:persona, user: user, game: game, name: "Foo") }
    let!(:p2) { FactoryGirl.create(:persona, user: user, game: game, name: "Bar") }
    

    before do
      user.claim_game!(game)
      sign_in user
      visit user_path(user) 
    end

    it { should have_selector('h1',    text: user.name) }
    it { should have_title(user.name) }
    
    describe "games" do
      before { sign_in user }
      it { should have_content(game.platform) }
    end
    
  
    describe "personas" do
       before { sign_in user }
      it { should have_content(p1.name) }
      it { should have_content(p2.name) }
      
      describe "create persona" do
      
      end
      
      describe "delete persona" do
        
      end
      
      describe "edit persona" do
        
      end
      
    end


    it { should have_selector('h1',    text: user.name) }
    it { should have_title(user.name) }

     describe "follow/unfollow buttons" do
        let(:other_user) { FactoryGirl.create(:user) }
        

        describe "following a user" do
          before { 
            sign_in user
            visit user_path(other_user) }

          it "should increment the followed user count" do
             expect do
                click_button "Add Friend"
              end.to change(user.followed_users, :count).by(1)
          end

          it "should increment the other user's followers count" do
            expect do
                click_button "Add Friend"
              end.to change(other_user.followers, :count).by(1)
          end

          describe "toggling the button" do
            before { click_button "Add Friend" }
            it { should have_xpath("//input[@value='Friendship Requested']") }
          end
          
             it "should generate a user activity" do
                     expect do
                          click_button "Add Friend"
                        end.to change(Activity, :count).by(1)
              end
              it "should send an e-mail" do
                  expect { click_button "Add Friend" }.to change(ActionMailer::Base.deliveries,:size).by(1)
                end
        end
        
        
        describe "accepting a friendship" do
          before do 
            user.follow!(other_user)
            sign_in other_user
            visit friend_requests_user_path(other_user)
         
          end 
          
            it { should have_content(user.name)} 
          
          
          it "should increment the user's follower's count" do
            expect do
                click_button "Accept"
              end.to change(user.followers, :count).by(1)
          end
          
          it "should increment both user's friends count" do
            expect do
                click_button "Accept"
              end.to change(user.friends, :count).by(1)
          end
          
          
           it "should increment other user's friends count" do
              expect do
                  click_button "Accept"
                end.to change(other_user.friends, :count).by(1)
            end
          
          it "should generate a user activity" do
                 expect do
                      click_button "Accept"
                    end.to change(Activity, :count).by(1)
          end
           it "should send an e-mail" do
              expect { click_button "Accept" }.to change(ActionMailer::Base.deliveries,:size).by(1)
            end
          
          
        end

        describe "unfollowing a user" do
          before do
            user.follow!(other_user)
            other_user.follow!(user)
            sign_in user
            visit user_path(other_user)
          end

          it "should decrement the followed user count" do
            expect do
                click_button "Unfriend"
              end.to change(user.followed_users, :count).by(-1)
          end

          it "should decrement the other user's followers count" do
            expect do
                click_button "Unfriend"
              end.to change(other_user.followers, :count).by(-1)
          end

          describe "toggling the button" do
            before { click_button "Unfriend" }
            it { should have_xpath("//input[@value='Add Friend']") }
          end
        end
    end
  end
  
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before do
        fill_in "Email",            with: ""
      end
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "friending/friends" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "friended users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_title(full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "friends" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_title(full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
  
  
 
end