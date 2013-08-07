namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_games
    make_relationships
    claim_games
    make_events
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       role: "admin")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    next_user = User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
    puts "created user #{next_user.name}"
  end
end



def make_games
  samplegamenames= ["World of Warcraft", "Minecraft", "Eve Online", "Guild Wars 2", "Star Wars: The Old Republic"]
  samplegamenames.each do |name|
    Game.create(name: name, platform: "PC")
    puts "created user #{name}"
  end  
end


def make_relationships
  users = User.all
  users.each do |user| 
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each do |followed| 
    user.follow!(followed) 
    puts "#{user.name} followed #{followed.name}"
  end
  followers.each do |follower| 
    follower.follow!(user) 
    puts "#{follower.name} followed #{user.name}"
    end
  end
end



def claim_games
  users = User.all
  users.each do |user| 
    3.times do |n| 
      game = Game.find(rand(1..5))
      user.claim_game!(game)
      puts "#{user.name} now owns #{game.name}"
    end
  end
end


def make_events
  users = User.all
  users.each do |user|
    5.times do |n|
      game = user.games.first
      fromtime = Time.now+rand(1..7).days
      totime = fromtime + 1.hour
      event = user.hosted_events.build(game: game, fromtime: Time.now+(n+user.id).days, totime: Time.now + 1.hour + (n+user.id+1).days)
      puts "#{user.name} is hosting a #{game.name} game"
      event.save
      invitees = user.friends[1..5]
      invitees.each do |invitee|
        event.invite!(invitee) 
        puts "#{user.name} invited #{invitee.name}"
        if rand(1..2) == 2
          invitee.accept_invite!(event)
          puts "#{invitee.name} has accepted #{user.name}'s invitation!"
        end
      end
    end
  end   
end
  


