class MockConstants
  attr_reader :target
  
  def self.on target
    new.on target
  end
  def self.with add_or_update_hash={}, remove_list={}
    new.with add_or_update_hash, remove_list
  end
  
  def initialize target = Object
    @removed_constants = []
    @added_or_changed_constants = []
    on target
  end
  def on target
    @target = target
    self
  end
  def with update_hash={}, remove_list={}
    install update_hash
    remove remove_list
    result = yield
  ensure
    restore
    result
  end
  def install update_hash={}
    raise ArgumentError unless (update_hash.keys & (@added_or_changed_constants | @removed_constants)).empty?
    @added_or_changed_constants += update_hash.keys
  end
  def remove symbol_or_list
    symbol_or_list = [symbol_or_list] if symbol_or_list.kind_of? Symbol
    raise ArgumentError unless symbol_or_list.all?{|const| target.const_defined? const}
    raise ArgumentError unless (symbol_or_list & @added_or_changed_constants).empty?
    @removed_constants += symbol_or_list
    remove_list symbol_or_list
  end
  def restore
  end
private
  def remove_list remove_list
  end
end
