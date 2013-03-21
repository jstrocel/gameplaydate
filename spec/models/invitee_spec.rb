require 'spec_helper'

describe Invitee do
  it { should respond_to (:invite_id)}
  it { should respond_to (:user_id)}
  it { should respond_to (:accepted)}
end
