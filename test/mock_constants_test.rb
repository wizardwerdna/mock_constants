require 'minitest_helper'
require File.expand_path('../../lib/mock_constants', __FILE__)

describe "API shortcuts" do
  subject{stub}
  it "MockConstants.on(...) is a shortcut for MockConstants::Base.new.on(...)" do
    container = stub
    subject.expects(:on).with(container)
    MockConstants::Base.expects(:new).returns(subject)
    MockConstants.on(container)
  end
  
  it "MockConstants.with(...) is a shortcut for MockConstants::Base.new.with(...)" do
    hash, list, block = stub, stub, lambda{}
    subject.expects(:with).with(hash, list)
    MockConstants::Base.expects(:new).returns(subject)
    MockConstants.with(hash, list, &block)
  end
end
