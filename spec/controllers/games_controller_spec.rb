require File.dirname(__FILE__) + '/../spec_helper'

describe GamesController do
  let(:game) { FactoryGirl.create(:game) }
  let(:user) {FactoryGirl.create(:user)}
    before { sign_in user }
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => game
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "edit action should render edit template" do
    get :edit, :id => game
    response.should render_template(:edit)
  end

  it "destroy action should destroy model and redirect to index action" do
    delete :destroy, :id => game
    response.should redirect_to(games_url)
    Game.exists?(game.id).should be_false
  end
end
