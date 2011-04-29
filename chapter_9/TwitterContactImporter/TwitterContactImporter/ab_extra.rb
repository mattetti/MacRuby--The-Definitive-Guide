# ab_extra.rb
#
# Created by Matt Aimonetti


class Hash

  def to_ab_multivalue
    multivalue = ABMutableMultiValue.alloc.init
    self.each {|key,value| multivalue.addValue(value, withLabel:key) }
    multivalue
  end
  
end