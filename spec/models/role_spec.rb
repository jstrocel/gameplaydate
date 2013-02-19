require 'spec_helper'

describe Role do
  
  before { @role = User.new(name: "admin") }

    subject { @role }
  
  it { should respond_to(:name) }
end
