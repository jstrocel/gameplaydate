require 'spec_helper'

describe BetaInvitation do
 let (:sender_user) {FactoryGirl.create(:user)}  
 let (:already_registered_user) {FactoryGirl.create(:user)} 
 before { @beta_invite = BetaInvitation.new(sender: sender_user, recipient_email:"beta_user@example.com")}
 
 subject{@beta_invite}
 
 it { should respond_to (:sender)}
 it { should respond_to (:recipient)}
 it {should be_valid}
 
 describe 'sending an invitation' do
   
   
   it "should notify the user through email" do
     expect {@beta_invite.save}.to change(ActionMailer::Base.deliveries,:size).by(1)
    end
   
   
   
 end
 
end