require 'spec_helper'
require 'pp'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    #it { should respond_to(:role) }
    it { should respond_to(:admin) }
    it { should respond_to(:invites) }
    it { should respond_to(:games) }
    #it { should respond_to(:personas) }
    it { should respond_to(:friendships) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:hosted_events)}
    it { should respond_to(:all_events)}
    it { should be_valid}
    

    pending "accessible attributes" do
      it "should not allow access to admin" do
        expect do
          User.new(role: "admin")
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end    
    end
    
    describe "with admin attribute set to 'true'" do
      before do
        @user.save!
        @user.toggle!(:admin)
      end

      it { should be_admin }
    end
    
    
    describe "when name is not present" do
      before { @user.name = " " }
      it { should_not be_valid }
    end

    describe "when email is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
    end
    
    describe "when password is not present" do
      before { @no_pass = User.new(name: "Example User", email: "user@example.com", password: "", password_confirmation: "foobar")
        @no_pass.save
         }
      it "should not be valid" do
        @no_pass.should_not be_valid
      end
    end
    
    describe "when password doesn't match confirmation" do
      before { @no_pass_conf = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar1")
        @no_pass_conf.save
         }
      it "should not be valid" do
        @no_pass_conf.should_not be_valid
      end
    end
    
    describe "when password confirmation is nil" do
       before { @no_pass_confnil = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "")
          @no_pass_confnil.save
           }
        it "should not be valid" do
          @no_pass_confnil.should_not be_valid
        end
    end
    
    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
    
    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by(email: @user.email) }

      describe "with valid password" do
        it { should == found_user.authenticate(@user.password) }
      end

      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false }
      end
    end
    
    describe "remember token" do
       before { @user.save }
       its(:remember_token) { should_not be_blank }
     end

    describe "when name is too long" do
      before { @user.name = "a" * 51 }
      it { should_not be_valid }
    end
    
    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.should_not be_valid
        end      
      end
    end

    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          @user.should be_valid
        end      
      end
    end

    describe "when email address is already taken" do
      before do
        @user.save
        @user_with_same_email = @user.clone
        @user_with_same_email.email = @user.email.upcase
        @user_with_same_email.save
      end

      it  "should not be valid" do
        @user_with_same_email.should_not be_valid
      end
      
    end
    
    describe "email address with mixed case" do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

      it "should be saved as all lower-case" do
        @user.email = mixed_case_email
        @user.save
        @user.reload.email.should == mixed_case_email.downcase
      end
    end
    
    describe "email address in all caps" do
      let(:mixed_case_email) { "FOO@EXAMPLE.COM" }

      it "should be saved as all lower-case" do
        @user.email = mixed_case_email
        @user.save
        @user.reload.email.should == mixed_case_email.downcase
      end
    end
    
    
    describe "with a password that's too short" do
       before { @user.password = @user.password_confirmation = "a" * 5 }
       it { should be_invalid }
     end
    
    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by( email:@user.email) }

      describe "with valid password" do
        it { should == found_user.authenticate(@user.password) }
      end

      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false }
      end
    end
    
    
    context "friends list" do
      before{
        @friend1 = FactoryGirl.create(:user)
        @friend2 = FactoryGirl.create(:user)
        @friend1.request_friend(@friend2)
      }
    
      it "should be able to request friends" do
        @friend2.pending_friend_ids.include?(@friend1.id).should be_true
      end
        
        pending "should be able to accept friends" do
         @friend2.accept_friend(@friend1)
         @friend2.friend_ids.include?(@friend1.id).should be_true
      end
            pending "should remove friends" do
            @friend2.accept_friend(@friend1)
            @friend2.remove_friend(@friend1)
            @friend2.friend_ids.include?(@friend1.id).should be_false
          end
    end
    
    describe "should have many events through invitations" do
      before{
        @game1 = FactoryGirl.create(:game)
        @player1 = FactoryGirl.create(:user)

        params1 ={event: { game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now,
           invites_attributes: [{ user_id: @player1.id, status: "organizer"}]}}
        @event1 = Event.create(params1[:event])
        @player2 = FactoryGirl.create(:user)
        @event1.save
        @event1.invite!(@player2)      
      }
      it "should create invitations" do
   
        @player2.events.first.should == @event1
      end
      
      it "the created invite should be pending" do
          @player2.pending_invites.should include(@event1)
      end
      
      it "user.events should have events the user has organized and has been invited to" do
        params2 ={event: { game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now,
           invites_attributes: [{ user_id: @player2.id, status: "organizer"}]}}
        @event2 = Event.create(params2[:event])
        @event2.save
        @player2.events.should include(@event1, @event2)
      end
    end
  
    pending "sends a e-mail" do
        @user.send_instructions
        ActionMailer::Base.deliveries.last.to.should == [@user.email]
      end
    
    
end