
@game1 = FactoryGirl.create(:game)
@player1 = FactoryGirl.create(:user)
@player2 = FactoryGirl.create(:user)
params1 ={event: { game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now}}
@event1 = Event.create(params1[:event])
@invite1 = @event1.invites.build(user:@player1, status:"organizer")
@event1.invite!(@player2)
params2 ={event: { game: @game1, fromtime: 2.hours.from_now, totime: 3.hours.from_now,
   invites_attributes: [{ user_id: @player2.id, status: "organizer"}]}}
@event2 = Event.create(params2[:event])