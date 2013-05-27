require 'spec_helper'

describe Invite do
 
  let (:host) {FactoryGirl.create(:user, :with_events)}
  before{@invite = host.events.first.invites.first
    }
  
   subject{@invite}
  
  it { should respond_to (:event)}
  it { should respond_to (:user)}
  it { should respond_to (:accepted)}
  
  it { should be_valid }
  
  
    describe "should not be able to invite a user twice" do
      before{ @invite.user = host.events.first.invites.last.user }    
        it { should_not be_valid }
    end
  
end
