# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :persona do
    game_id ""
    user_id ""
    sequence(:name)  { |n| "Character #{n}" }
    server 1
  end
end
