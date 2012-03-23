require 'minitest/autorun'
require 'mocha'
require 'mock_constants/mock_constants'

describe MockConstants do
  subject{MockConstants.new Kernel}
  describe "API" do
    
    it "should should default to targetting Object" do
      MockConstants.new.target.must_equal Object
    end
    
    it "should permit defining a target on creation" do
      subject.target.must_equal Kernel
    end
    
    it "should respond with self to #on to facilitate chaining" do
      subject.on(Module).must_equal subject
    end
    
    it "should permit changing a target after creation" do
      subject.on(Module).target.must_equal Module
    end
    
    it "#with should wrap install, remove and restore with a single operation, and return the value of the block" do
      constants_spec = stub
      removal_list = stub
      return_stub = stub
      proc = lambda{return_stub}
      subject.expects(:install).with(constants_spec)
      subject.expects(:remove).with(removal_list)
      subject.expects(:restore)
      subject.with(constants_spec, removal_list, &proc).must_equal return_stub
    end
    
    it "#with should wrap with install, remove and restore even when proc raises an error" do
      constants_spec = stub
      removal_list = stub
      return_stub = stub
      proc = lambda{raise RuntimeError}
      subject.expects(:install).with(constants_spec)
      subject.expects(:remove).with(removal_list)
      subject.expects(:restore)
      lambda{subject.with(constants_spec, removal_list, &proc)}.must_raise RuntimeError
    end    
  end
  
  describe "API shortcuts" do
    it "MockConstants.on(...) is a shortcut for MockConstants.new.on(...)" do
      subject.expects(:on)
      MockConstants.expects(:new).returns(subject)
      MockConstants.on(Kernel)
    end
    
    it "MockConstants.with(...) is a shortcut for MockConstants.new.with(...)" do
      subject.expects(:with)
      MockConstants.expects(:new).returns(subject)
      MockConstants.with({},[]){}
    end
    
    it "MockConstants.new.remove(:A) is a shortcut for MockConstants.new.remove([:A])" do
      subject.expects(:remove_list).with([:A])
      subject.on(Module.new).remove(:A)
    end
  end
  
end