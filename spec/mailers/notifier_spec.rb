require 'spec_helper'
 
describe Notifier, :focus=> true do
  describe 'registration_confirmation' do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { Notifier.registration_confirmation(user.id) }
    
    before do
      ResqueSpec.reset!
      mail.deliver
    end
    subject { described_class }
    it { should have_queue_size_of(1) }
    it { should have_queued(:registration_confirmation, user.id) }
 
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
  
  describe 'password_reset' do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { Notifier.password_reset(user.id) }
    
    before do
      ResqueSpec.reset!
      mail.deliver
    end
    subject { described_class }
    it { should have_queue_size_of(1) }
    it { should have_queued(:password_reset, user.id) }      
  end
  
  
  
  
  
  
  
  describe 'send_beta_invite' do
    let (:host) {FactoryGirl.create(:user)}
    let (:beta_invitee_email) {"anybody@home.com"}
    let (:beta_invitation) {FactoryGirl.create(:beta_invitation, :sender=>host, :recipient_email=>beta_invitee_email)}
    let(:mail) { Notifier.send_beta_invite(beta_invitation.id) }
    
    before do
      ResqueSpec.reset!
      mail.deliver
    end
    subject { described_class }
    it { should have_queue_size_of(1) }
    it { should have_queued(:send_beta_invite, beta_invitation.id) }
    
    
      it 'renders the subject' do
       mail.subject.should include('has invited you to GamePlayDate')
       mail.subject.should include(host.name)
      end

      it 'renders the receiver email' do
         mail.to.should == [beta_invitee_email]
        end

        it 'renders the sender email' do
           mail.from.should == ['no-reply@gameplaydate.com']
        end

        it 'includes the beta inviters name' do
          mail.body.encoded.should match(host.name)
        end
        
        it 'includes the signup url' do
          mail.body.encoded.should match(beta_signup_url(beta_invitation.token))
        end
  
  end
  
  
  
  describe 'send_invite' do
    let (:host) {FactoryGirl.create(:user)}
    let (:invitee1) {FactoryGirl.create(:user)}
    let (:invitee2) {FactoryGirl.create(:user)}
    let (:game) {FactoryGirl.create(:game)}
    let (:event) {host.hosted_events.create(game: game, fromtime: 2.hours.from_now, totime: 3.hours.from_now)}
    let(:mail) { Notifier.send_invite(invitee1.id, event.id) }
    
    before do
      ResqueSpec.reset!
      mail.deliver
    end
    
    subject { described_class }
    it { should have_queue_size_of(1) }
    it { should have_queued(:send_invite, invitee1.id, event.id) }
    
    it 'renders the subject' do
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
      
      it 'includes a link to the event' do
        mail.body.encoded.should match(event_path(event))
      end
      
      it 'includes the event start time' do
        mail.body.encoded.should match(event.fromtime.strftime("%A, %B %e %Y,%l:%M %P"))
      end
      
      it 'includes the event end time' do
        mail.body.encoded.should match(event.totime.strftime("%A, %B %e %Y,%l:%M %P"))
      end
      
  end
  
end