# ab_record.rb
#
# Created by Matt Aimonetti

class ABRecord

  # creates an accessor for a new custom property
  # usage:
  #  ABPerson.new_string_accessor('twitter', 'mattetti.twitter')
  #  me = ABAddressBook.sharedAddressBook.me
  #  me.twitter = 'merbist'
  #  me.twitter # => 'merbist'
  def self.new_string_accessor(method_name, key)
    self.addPropertiesAndTypes(key => KABStringProperty)
    self.send(:define_method, method_name) do
      self.valueForProperty(key)
    end
    self.send(:define_method, "#{method_name}=") do |val|
      self.setValue(val, forProperty: key)
    end
    true
  end
  
  
  # makes abperson_instance.firstName and abperson_instance.firstName = 'matt' available
  def method_missing(m, *args, &block)
    missing_meth = m.to_s
    missing_meth[0] = missing_meth[0].upcase
    if missing_meth.include?('=')
      constant_name = "KAB#{missing_meth.gsub('=', '')}Property"
      if Object.const_defined?(constant_name)
        constant = Object.const_get(constant_name)
        self.class.send(:define_method, m.to_s) do |param|
          self.setValue(param, forProperty:constant)
        end
        self.setValue(args.first, forProperty:constant)
      else
        super
      end
      
    elsif
      constant_name = "KAB#{missing_meth}Property"
      if Object.const_defined?(constant_name)
        constant = Object.const_get(constant_name)
        self.class.send(:define_method, m.to_s) do 
          self.valueForProperty constant
        end
        self.valueForProperty constant
      
      else
        super
      end
    end
  end
  
end


