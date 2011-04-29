# ab_group.rb
#
# Created by Matt Aimonetti

class ABGroup

  def name=(value)
    self.setValue(value, forProperty: 'name')
  end
  
  def <<(person)
    raise TypeError, "You can only add an ABPerson instance to a group" unless person.is_a?(ABPerson)
    self.addMember(person) unless person.parentGroups.map{|name| name}.include?(self.name)
  end
  
end
