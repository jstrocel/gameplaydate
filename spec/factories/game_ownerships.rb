# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_ownership do
    user_id ""
    game_id ""
    status "MyString"
  end
end
