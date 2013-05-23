require 'spec_helper'

describe Invite do
  it { should respond_to (:event)}
  it { should respond_to (:user)}
  it { should respond_to (:accepted)}
end
