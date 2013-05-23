FactoryGirl.define do 
 factory :user do
   sequence(:name)  { |n| "Person #{n}" }
   sequence(:email) { |n| "person_#{n}@example.com"}   
   password "foobar"
   password_confirmation "foobar"
   factory :admin do
     admin true
   end
   trait :user_with_invite do
     after :create do |user|
           FactoryGirl.create_list :invite, 3, :user => user
         end
   end
 end
 
 factory :game do
   sequence(:name)  { |n| "Game #{n}" }
 end

 
 
 factory :invite do
  game_id "1" 
  sequence(:fromtime) { |n| Time.now + n.weeks }
  sequence(:totime) { |n| Time.now + n.weeks + 1.hour }
  maximum_players 5
 end
 
end