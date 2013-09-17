FactoryGirl.define do 
  
  factory :beta_invitation do
     sequence(:recipient_email) { |n| "beta_user_#{n}@example.com"}
     sent_at DateTime.now
  end
  
  
 factory :user do
 
   #@beta_invite = FactoryGirl.create(:beta_invitation) 
   sequence(:name)  { |n| "Person #{n}" }
   #email @beta_invite.recipient_email
   sequence(:email) { |n| "person_#{n}@example.com"}  
   #beta_invitation @beta_invite
   password "foobar"
   password_confirmation "foobar"
   beta_invitation_limit 5
   time_zone 'Pacific Time (US & Canada)'
   factory :admin do
     admin true
     role "admin"
   end
   trait :with_events do
     after :create do |user|
           FactoryGirl.create_list( :event, 3, organizer:user)
         end
   end
   
   trait :with_games do
      after :create do |user|
       FactoryGirl.create_list :game,  3
      end      
    end
   before
   
 end
 
 factory :game do
   sequence(:name)  { |n| "Game #{n}" }
   platform "PC"
 end

 
 factory :event do
  game {FactoryGirl.create(:game) }
  sequence(:fromtime) { |n| Time.now + n.weeks }
  sequence(:totime) { |n| Time.now + n.weeks + 1.hour }
  maximum_players 5
  trait :with_invites do
     after :create do |event|
           FactoryGirl.create_list :invite, 3, :event => event
         end
   end
   trait :with_max_invites do
      after :create do |event|
            FactoryGirl.create_list :invite, 5, :event => event
          end
    end
 end
 
 factory :invite do
   event
   user
 end
 
end