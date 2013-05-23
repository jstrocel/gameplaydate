require 'spec_helper'

describe Invitee do
  it { should respond_to (:invite)}
  it { should respond_to (:user)}
  it { should respond_to (:accepted)}
end
