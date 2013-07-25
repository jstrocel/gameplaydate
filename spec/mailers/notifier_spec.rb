require 'spec_helper'
 
describe Notifier do
  describe 'registration_confirmation' do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { Notifier.registration_confirmation(user) }
 
    it 'renders the subject' do
     mail.subject.should == 'Welcome to GamePlayDate!'
    end
 
  it 'renders the receiver email' do
     mail.to.should == [user.email]
    end
 
    it 'renders the sender email' do
       mail.from.should == ['no-reply@gameplaydate.com']
    end
 
    it 'assigns @name' do
      mail.body.encoded.should match(user.name)
    end
 
 
  end
  
  describe 'send_invite' do
    let (:host) {FactoryGirl.create(:user)}
    let (:invitee1) {FactoryGirl.create(:user)}
    let (:invitee2) {FactoryGirl.create(:user)}
    let (:game) {FactoryGirl.create(:game)}
    let (:event) {host.hosted_events.build(game: game, fromtime: 2.hours.from_now, totime: 3.hours.from_now)}
    let(:mail) { Notifier.send_invite(invitee1, event) }
    
    it 'renders the subject' do
      #TODO refactor
     mail.subject.should include('You have been invited to play')
     mail.subject.should include(event.game.name)
    end
    
    
    it 'renders the receiver email' do
       mail.to.should == [invitee1.email]
      end
      
      it 'renders the sender email' do
         mail.from.should == ['no-reply@gameplaydate.com']
      end

      
      it 'includes the invitee name' do
        mail.body.encoded.should match(invitee1.name)
      end
      
      it 'includes the game to be played' do
        mail.body.encoded.should match(event.game.name)
      end
      
      it 'includes the organizers name' do
        mail.body.encoded.should match(event.organizer.name)
      end
      
      
    
  end
  
end