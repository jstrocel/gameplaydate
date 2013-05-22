namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    #make_microposts
    make_friendships
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_friendships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_games
  samplegamenames= ["World of Warcraft", "Minecraft", "Eve Online", "Guild Wars 2", "Star Wars: The Old Republic"]
  samplegamenames.each do |name|
    Game.create(name: name, platform: "PC")
  end  
end

def make_invites
  10.times do |n|
   content = Faker::Lorem.sentence(5)
   Invite.create!(
   game_id:rand(5),
   maximum_players:5,
   fromtime: Time.now + n.weeks,
   totime: Time.now + n.weeks + 1.hour,
   content:content)
  end  
end


