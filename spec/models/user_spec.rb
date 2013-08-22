require 'spec_helper'
require 'pp'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:admin) }
    it { should respond_to(:invites) }
    it { should respond_to(:games) }
    it { should respond_to(:personas) }
    it { should respond_to(:friendships) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:hosted_events)}
    it { should respond_to(:events)}
    it { should respond_to(:role)}
    it { should respond_to (:beta_invitation_id)}
    it { should respond_to (:beta_invitation_limit)}
    it { should respond_to(:activities) }
    it { should be_valid}
    
    describe "signing up a beta_user" do
      before do
        @user.role = "beta_user"
        @user.beta_invitation_id = nil
      end
     it {should_not be_valid}
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
      before do
        @user = User.new(name: "Example User", email: "user@example.com", 
                         password: " ", password_confirmation: " ")
      end
      it { should_not be_valid }
    end

    describe "when password doesn't match confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end

    describe "when password confirmation is nil" do
      before do
        @user = User.new(name: "Michael Hartl", email: "mhartl@example.com",
                         password: "foobar", password_confirmation: nil)
      end
      it { should_not be_valid }
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

          it { should_not eq user_for_invalid_password }
          specify { expect(user_for_invalid_password).to be_false }
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
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end      
      end
    end

    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end      
      end
    end

    describe "when email address is already taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end

      it { should_not be_valid }
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

          it { should_not eq user_for_invalid_password }
          specify { expect(user_for_invalid_password).to be_false }
        end
    end
    
    
    describe "friends list" do
      before{
        @friend1 = FactoryGirl.create(:user)
        @friend2 = FactoryGirl.create(:user)
        @friend1.follow!(@friend2)
        @friend2.follow!(@friend1)
      }
      it "should contain friends" do
       @friend1.friends.include?(@friend2).should be_true
       @friend2.friends.include?(@friend1).should be_true
      end
      
      it "should have the correct number of friends" do
        @friend1.friends.count.should eq(1)
         @friend2.friends.count.should eq(1)
    
        
      end
      
      it "should be possible to remove friends" do
         @friend1.unfollow!(@friend2)
         @friend1.friends.include?(@friend2).should be_false
         @friend2.friends.include?(@friend1).should be_false
      end
      
    end
    

    
    
    describe "should have many events through invitations" do
      before{
        @game1 = FactoryGirl.create(:game)
        @player1 = FactoryGirl.create(:user)
        @event1 = Event.create(organizer_id: @player1.id, game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now)
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
      
      it "should be able to accept the invite" do
        expect{@player2.accept_invite!(@event1)}.to change(@player2.confirmed_events, :count).by(1)
      end
      
      
      
      it "user.events should have events the user has organized and has been invited to" do
        params2 ={event: { game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now }}
        @event2 = @player2.hosted_events.build(params2[:event])
        @event2.save
        @player2.events.should include(@event1, @event2)
      end
    end
    
    
    

    
    
end