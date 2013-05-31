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

   it { should have_selector('title', text: 'All Users') }
   
   
   describe "pagination" do

     before(:all) { 30.times { FactoryGirl.create(:user) } }
     after(:all)  { User.delete_all }

     let(:first_page)  { User.paginate(page: 1) }
     let(:second_page) { User.paginate(page: 2) }

     it { should have_link('Next') }
     its(:html) { should match('>2</a>') }

     it "should list each user" do
       User.all[0..2].each do |user|
         page.should have_selector('li', text: user.name)
       end
     end

     it "should list the first page of users" do
       first_page.each do |user|
         page.should have_selector('li', text: user.name)
       end
     end

     it "should not list the second page of users" do
       second_page.each do |user|
         page.should_not have_selector('li', text: user.name)
       end
     end

     describe "showing the second page" do
       before { visit users_path(page: 2) }

       it "should list the second page of users" do
         second_page.each do |user|
           page.should have_selector('li', text: user.name)
         end
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
           expect { click_link('delete') }.to change(User, :count).by(-1)
         end
         it { should_not have_link('delete', href: user_path(admin)) }
       end
     end
   end

 describe "profile page" do
  let(:user) { FactoryGirl.create(:user) }
   before { visit user_path(user) }

   it { should have_selector('h1',    text: user.name) }
   it { should have_selector('title', text: user.name) }
 end
 
 describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "error messages" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
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

      describe "after saving the user" do
        before { click_button submit }
        
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
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
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
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

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
  
    end
  end
  
  describe "messages page" do
    
    #before {visit message_path(user)}
    
    pending "it should list messages" do
      pending "each listing should have first 50 characters of recipient names"
      pending "each listing should ahve the first 50 characters of the most recent message"
    end
    
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
   # let(:invite1){FactoryGirl.create(:invite)}
   # let(:invite2) {FactoryGirl.create(:invite)}

    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

  /  describe "invites" do
      it { should have_content(invite1.content) }
      it { should have_content(invite2.content) }
      it { should have_content(user.invitees.count) }
    end/

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "friend/unfriend buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "friending a user" do
        before { visit user_path(other_user) }

        it "should increment the friended user count" do
          expect do
            click_button "Add Friend"
          end.to change(user.friended_users, :count).by(1)
        end

        it "should increment the other user's friends count" do
          expect do
            click_button "Add Friend"
          end.to change(other_user.friends, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Add Friend" }
          it { should have_selector('input', value: 'Unfriend') }
        end
      end

      describe "unfriending a user" do
        before do
          user.friend!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the friended user count" do
          expect do
            click_button "Unfriend"
          end.to change(user.friends, :count).by(-1)
        end

        it "should decrement the other user's friends count" do
          expect do
            click_button "Unfriend"
          end.to change(other_user.friends, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfriend" }
          it { should have_selector('input', value: 'Follow') }
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
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
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

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "friending/friends" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.friend!(other_user) }

    describe "friended users" do
      before do
        sign_in user
        visit friend_user_path(user)
      end

      it { should have_selector('title', text: full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "friends" do
      before do
        sign_in other_user
        visit friends_user_path(other_user)
      end

      it { should have_selector('title', text: full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
  
  
 
end