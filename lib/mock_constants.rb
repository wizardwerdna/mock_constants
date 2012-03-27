require 'mock_constants/version'
require 'mock_constants/base'
require 'mock_constants/minispec'

module MockConstants
  def self.on holder
    Base.new.on holder
  end
  
  def self.with hash={}, list=[]
    Base.new.with hash, list
  end

  def self.minispec hash={}, list=[], &block
    MockConstants::MiniSpec.minispec hash, list, &block
  end
end