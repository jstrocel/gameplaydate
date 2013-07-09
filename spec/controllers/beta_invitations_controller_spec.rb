require File.dirname(__FILE__) + '/../spec_helper'

describe BetaInvitationsController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  pending "create action should render new template when model is invalid" do
    BetaInvitation.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  pending "create action should redirect when model is valid" do
    BetaInvitation.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
  end
end
