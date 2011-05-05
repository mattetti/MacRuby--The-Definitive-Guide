class String
  def blank?
    self.nil? || self.empty?
  end
  
  def to_nsurl
    NSURL.alloc.initWithString(self.to_s)
  end
end

class NilClass
  def blank?
    true
  end
end