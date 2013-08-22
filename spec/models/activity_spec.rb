require 'spec_helper'

describe Activity do
  it { should respond_to(:user) }
  it { should respond_to(:trackable) }
end
