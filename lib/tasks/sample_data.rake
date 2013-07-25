namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_games
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
    next_user = User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
   / if n > 5
    5.times do |x|  
      previous_user = User.find(n-x)
      if previous_user
        next_user.follow!(previous_user)
        previous_user.follow!(next_user)
      end
     end  
    end/
  end
end

def make_games
  samplegamenames= ["World of Warcraft", "Minecraft", "Eve Online", "Guild Wars 2", "Star Wars: The Old Republic"]
  samplegamenames.each do |name|
    Game.create(name: name, platform: "PC")
  end  
end





