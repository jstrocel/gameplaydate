require 'spec_helper'

describe Game do
 it { should respond_to (:name)}
 it { should respond_to (:platform)}
end
