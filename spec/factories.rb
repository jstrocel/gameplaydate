FactoryGirl.define do 
 factory :user do
   sequence(:name)  { |n| "Person #{n}" }
   sequence(:email) { |n| "person_#{n}@example.com"}   
   password "foobar"
   password_confirmation "foobar"
 end
 
 factory :game do
   sequence(:name)  { |n| "Game #{n}" }
 end
 
 factory :admin do
   role "admin"
 end
 
 factory :invitee do
 end
 
end