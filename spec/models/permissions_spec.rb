
describe Permission do
  
  describe "as guest" do
    subject { Permission.new(nil) }
    
    it "allows static pages" do
      should allow(:static_pages, :home)
      should allow(:static_pages, :help)
    end

    it "allows sessions" do
      should allow(:sessions, :new)
      should allow(:sessions, :create)
      should allow(:sessions, :destroy)
    end

    it "allows users" do
      should allow(:users, :new)
      should allow(:users, :create)
      should_not allow(:users, :edit)
      should_not allow(:users, :index)
      should_not allow(:users, :show)
      should_not allow(:users, :update)
    end
  end
  
  
  describe "as user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    let(:user_event) { FactoryGirl.create(:event, organizer: user) }
    let(:other_event) { FactoryGirl.create(:event, organizer: other_user) }
    let(:persona) { FactoryGirl.create(:persona, user: user) }
    let(:other_persona) { FactoryGirl.create(:persona) }
    
    subject { Permission.new(user) }
    
    it "allows static pages" do
      should allow(:static_pages, :home)
      should allow(:static_pages, :help)
    end

    it "allows sessions" do
      should allow(:sessions, :new)
      should allow(:sessions, :create)
      should allow(:sessions, :destroy)
    end

    it "allows users" do
      should allow(:users, :new)
      should allow(:users, :create)
      should allow(:users, :index)
      should allow(:users, :show)
      should_not allow_param(:users, :role)
      should allow(:users, :edit, user)
      should allow(:users, :update, user)
      should allow(:users, :destroy, user)
      should_not allow(:users, :edit, other_user)
      should_not allow(:users, :update, other_user)
      should_not allow(:users, :destroy, other_user)
    end
    
  
    it "allows events" do
          should allow(:events, :new)
          should allow(:events, :create)
          should allow(:events, :index)
          should allow(:events, :show)
          should allow(:events, :edit, user_event)
          should allow(:events, :update, user_event)
          should_not allow(:events, :edit, other_event)
          should_not allow(:events, :update, other_event)
          should allow(:events, :destroy, user_event)
          should_not allow(:events, :destroy, other_event)
    end
    
    
    

    describe "as admin" do
      subject { Permission.new(FactoryGirl.create(:admin)) }

      it "allows anything" do
        should allow(:anything, :here)
        should allow_param(:anything, :here)
      end
    end
    
  end
  

  
end
