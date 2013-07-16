require File.dirname(__FILE__) + '/../spec_helper'

describe BetaInvitationsController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
end
