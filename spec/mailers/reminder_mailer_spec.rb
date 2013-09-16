require "spec_helper"

describe ReminderMailer do
   include ActionView::Helpers::DateHelper
    let(:organizer) { FactoryGirl.create(:user) }
    let(:invitee1) { FactoryGirl.create(:user) }
    let(:invitee2) { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event, :organizer=> organizer) }
    before do
      event.invite!(invitee1)
      event.invite!(invitee2)
    end
  
  
  
  describe "#remind_organizer" do
    let(:mail) { ReminderMailer.remind_organizer(organizer, event) }
  

       it 'renders the subject' do
         mail.subject.should include('You have an event in')
         mail.subject.should include(distance_of_time_in_words_to_now(event.fromtime))
        end

    it 'renders the receiver email' do
       mail.to.should == [organizer.email]
      end

    it 'renders the sender email' do
      mail.from.should == ['no-reply@gameplaydate.com']
    end

    it 'includes the organizers name' do
       mail.body.encoded.should match(organizer.name)
    end
  end
  
  describe "#remind_invitee" do
    let(:mail) { ReminderMailer.remind_invitee(invitee1, event) }
  

       it 'renders the subject' do
         mail.subject.should include('You have an event in')
         mail.subject.should include(distance_of_time_in_words_to_now(event.fromtime))
        end

    it 'renders the receiver email' do
       mail.to.should == [invitee1.email]
      end

    it 'renders the sender email' do
      mail.from.should == ['no-reply@gameplaydate.com']
    end

    it 'includes the organizers name' do
       mail.body.encoded.should match(invitee1.name)
    end
  end
end
