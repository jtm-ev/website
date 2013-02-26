
module Navigatable
  extend ActiveSupport::Concern
  
  # included do
  #   # scope :previous,  lambda { |i| {conditions: ["#{self.table_name}.id > ?", i.id]} }
  #   # scope :next,      lambda { |i| {conditions: ["#{self.table_name}.id < ?", i.id]} }
  #   scope :previous, lambda { |m|
  #     ids = select('id').map {|mm| mm.id}
  #     index = ids.index(m.id)
  #     pindex = ids.index(index - 1)
  #     pindex.nil? ? nil : where(id: ids[pindex] )
  #   }
  #   
  #   scope :next, lambda { |m|
  #     ids = select('id').map {|mm| mm.id}
  #     # puts "IDs: #{ids.inspect}"
  #     index = ids.index(m.id)
  #     pindex = ids.index(index + 1)
  #     # puts "Find ID: #{pindex}: #{self.class}"
  #     pindex.nil? ? nil : where(id: ids[pindex] )
  #   }
  #   
  #   # scope :next, lambda {}
  # end
  
  def next_in(scope)
    in_scope(scope, 1)
  end
  
  def previous_in(scope)
    in_scope(scope, -1)
  end
  
  private
    def in_scope(scope, offset = 1)
      ids = scope.map {|mm| mm.id}
      index = ids.index(self.id)
      pindex = index + offset
      return nil if pindex < 0
      
      pid = ids[pindex] rescue nil
      pid.nil? ? nil : self.class.find(pid)
    end
  
end