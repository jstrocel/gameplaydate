require 'spec_helper'
 
describe FriendNotify do
  
    let(:sender) { FactoryGirl.create(:user) }
     let(:accepter) { FactoryGirl.create(:user) }
  
  
  describe "#friend_request" do
     let(:mail) { FriendNotify.friend_request(sender.id, accepter.id) }
  

       it 'renders the subject' do
         mail.subject.should include('has requested to be your friend on GamePlayDate!')
         mail.subject.should include(sender.name)
        end

    it 'renders the receiver email' do
       mail.to.should == [accepter.email]
      end

    it 'renders the sender email' do
      mail.from.should == ['no-reply@gameplaydate.com']
    end

    it 'includes the senders name' do
       mail.body.encoded.should match(sender.name)
    end

    it 'includes the accepters name' do
       mail.body.encoded.should match(accepter.name)
    end
    
  end
  

  

  
  
  
  describe 'accept_friend_request' do
    let(:mail) { FriendNotify.accept_friend_request(sender.id, accepter.id) }

 
    it 'renders the subject' do
       mail.subject.should include('has accepted your friend request on GamePlaydate!')
       mail.subject.should include(accepter.name)
      end
 
  it 'renders the receiver email' do
     mail.to.should == [sender.email]
    end
 
  it 'renders the sender email' do
    mail.from.should == ['no-reply@gameplaydate.com']
  end

  it 'includes the senders name' do
     mail.body.encoded.should match(sender.name)
  end

  it 'includes the accepters name' do
     mail.body.encoded.should match(accepter.name)
  end
    
 
  end
  
  
end