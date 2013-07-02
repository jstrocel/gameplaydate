require 'spec_helper'

describe BetaInvitation do
  let(:sender) { FactoryGirl.create(:user) }
  #let(:recipient) { FactoryGirl.create(:user) }
  before {
    @beta_invite = BetaInvitation.new
    @beta_invite.sender = sender
    }
  
  subject { @beta_invite }
  
  #it { should respond_to(:sender_id) }
  #it { should respond_to(:recipient_email) }
  #it { should respond_to(:token) }
  #it { should respond_to(:sent_at) }
  
  #it { should be_valid } 
    
  
end
