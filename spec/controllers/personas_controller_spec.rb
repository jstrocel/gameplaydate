require File.dirname(__FILE__) + '/../spec_helper'

describe PersonasController do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game) }
  let (:persona){FactoryGirl.create(:persona, user:user, game:game)}
    before { sign_in user }
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => persona
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  pending "create action should render new template when model is invalid" do
    Persona.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  pending "create action should redirect when model is valid" do
    Persona.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(persona_url(assigns[:persona]))
  end

  it "edit action should render edit template" do
    get :edit, :id => persona
    response.should render_template(:edit)
  end

  pending "update action should render edit template when model is invalid" do
    Persona.any_instance.stubs(:valid?).returns(false)
    put :update, :id => persona
    response.should render_template(:edit)
  end

  pending "update action should redirect when model is valid" do
    Persona.any_instance.stubs(:valid?).returns(true)
    put :update, :id => persona
    response.should redirect_to(persona_url(assigns[:persona]))
  end

  it "destroy action should destroy model and redirect to profile url" do
    user_id = persona.user_id
    delete :destroy, :id => persona
    response.should redirect_to(user_path(user_id))
    Persona.exists?(persona.id).should be_false
  end
end
