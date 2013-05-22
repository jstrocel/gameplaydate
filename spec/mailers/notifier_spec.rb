require 'spec_helper'
 
describe Notifier do
  describe 'instructions' do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { Notifier.instructions(user) }
 
    #ensure that the subject is correct
    pending 'renders the subject' do
     mail.subject.should == 'Instructions'
    end
 
    #ensure that the receiver is correct
    pending 'renders the receiver email' do
     mail.to.should == [user.email]
    end
 
    #ensure that the sender is correct
    pending 'renders the sender email' do
       mail.from.should == ['noreply@empresa.com']
    end
 
    #ensure that the @name variable appears in the email body
    pending 'assigns @name' do
      mail.body.encoded.should match(user.name)
    end
 
    #ensure that the @confirmation_url variable appears in the email body
    pending 'assigns @confirmation_url' do
      mail.body.encoded.should match("http://aplication_url/#{user.id}/confirmation")
    end
  end
end