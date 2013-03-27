FactoryGirl.define do 
 factory :user do
   sequence(:name)  { |n| "Person #{n}" }
   sequence(:email) { |n| "person_#{n}@example.com"}   
   password "foobar"
   password_confirmation "foobar"
   factory :admin do
     admin true
   end
 end
 
 factory :game do
   sequence(:name)  { |n| "Game #{n}" }
 end
 /
 Factory.define :account do |f|
   f.after_build do |account|
     account.user ||= Factory.build(:user, :account => account)
     account.payment_profile ||= Factory.build(:payment_profile, :account => account)
     account.subscription ||= Factory.build(:subscription, :account => account)
   end
 end

 Factory.define :user do |f|
   f.after_build do |user|
     user.account ||= Factory.build(:account, :user => user)
     user.profile ||= Factory.build(:profile, :user => user)
   end
 end
 /
 factory :invitee do
   user
 end
 
 factory :invite do
  game 
  invitee 
 end
 
end