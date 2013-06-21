  @game1 = FactoryGirl.create(:game)
  @player1 = FactoryGirl.create(:user)
  @player2 = FactoryGirl.create(:user)
  @event1 = @player1.hosted_events.build(game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now)
  @valid_invite = @event1.invites.build(user: @player2, status: "pending")
  @event1.save
  @event2 = @player2.hosted_events.build(game: @game1, fromtime: @event1.fromtime, totime: @event1.totime)
  @invalid_invite = @event2.invites.build(user: @player2, status: "pending")
  @event2.valid?
  