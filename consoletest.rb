 @game1 = FactoryGirl.create(:game)
  @player1 = FactoryGirl.create(:user)
  @event1 = Event.create(game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now)
  @player2 = FactoryGirl.create(:user)
  @event1.save
  @event1.invite!(@player2)
  params2 ={event: { game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now }}
  @event2 = Event.create(params2[:event])
  @event2.save