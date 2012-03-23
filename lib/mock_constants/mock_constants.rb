class MockConstants
  attr_reader :target
  
  def self.on target
    new.on target
  end
  def self.with add_or_update_hash={}, remove_list={}
    new.with add_or_update_hash, remove_list
  end
  
  def initialize target = Object
    on target
  end
  def on target
    @target = target
    self
  end
  def with add_or_update_hash={}, remove_list={}
    install add_or_update_hash
    remove remove_list
    result = yield
  ensure
    restore
    result
  end
  def install add_or_update_hash
  end
  def remove symbol_or_list
    if symbol_or_list.kind_of? Symbol
      remove_list [symbol_or_list]
    else
      remove_list symbol_or_list
    end
  end
  def restore
  end
private
  def remove_list remove_list
  end
end