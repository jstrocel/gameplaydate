class FriendNotify < AsyncMailer
  layout 'email'
  default :from => 'GamePlayDate.com <no-reply@gameplaydate.com>'
  
  def friend_request(sender_id, accepter_id)
    sender = User.find(sender_id)
    accepter = User.find(accepter_id)
    @sender = sender
    @accepter =accepter
    mail(:to =>"#{accepter.name} <#{accepter.email}>", :subject => "#{sender.name} has requested to be your friend on GamePlayDate!")
  end
  
  def accept_friend_request(sender_id, accepter_id)
     sender = User.find(sender_id)
      accepter = User.find(accepter_id)
      @sender = sender
      @accepter =accepter
    mail(:to => "#{sender.name} <#{sender.email}>", :subject => "#{accepter.name} has accepted your friend request on GamePlaydate!")
  end
end
