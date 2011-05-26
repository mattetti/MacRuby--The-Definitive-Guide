framework 'Foundation'

class Player
  def add_contact(name, tags:contact_tags)
    @name = name
    @tags = contact_tags
    "new contact #{name} was added and tagged."
  end

  def add_contact(name, location:contact_location)
    @name = name
    @contact_location = contact_location
    "new contact #{name} was added and located."
  end
end

player = Player.new
puts player.add_contact('Matt', tags: ['Ruby', 'Cocoa'])  # => new contact Matt was added and tagged.
puts player.add_contact('Matt', location: 'San Diego')    # => new contact Matt was added and located.

# The following code raises an exception.
# We rescue the error and only print the message
# so the rest of the code can be executed.
begin
  player.add_contact('Matt') # => NoMethodError: undefined method `add_contact'
rescue Exception => e
  puts e.message
end

# The following code raises an exception.
# We rescue the error and only print the message
# so the rest of the code can be executed.
begin
  player.add_contact('Matt', tags: ['Ruby'], location: 'San Diego') # => NoMethodError:
rescue Exception => e
  puts e.message
end

puts "Ruby".insertString("Mac", atIndex:0)  # => "MacRuby"