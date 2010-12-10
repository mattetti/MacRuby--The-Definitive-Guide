# Examples
days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
days.each_with_index do |day, index|
  puts "day #{index + 1} of the week is #{day}"
end

days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
days.each_with_index{ |day, index|  puts "day #{index + 1} => #{day}" }

# Iterarors
macruby_genius = 'Laurent'
developers = ['laurent', 'josh', 'matt', 'jordan']
developers = developers.map do |dev| 
  macruby_genius = dev
end
macruby_genius # => "jordan"

# Scope
macruby_genius = 'Laurent'
developers = ['laurent', 'josh', 'matt', 'jordan']
def capitalize_developer_names(devs)
  devs.map do |dev| 
    macruby_genius = dev
  end
end
capitalize_developer_names(developers)
macruby_genius # => "Laurent"

# More examples
class Contact; end

contacts = []
5.times do 
  contacts << Contact.new
end

# Or you can use this shorted syntax
contacts = Array.new(5){ Contact.new }

# C Blocks
# Requires BridgeSupport Preview 1 installed
# or OS X > 10.6
framework 'Foundation'
array = [1, 2, 3, 4, 5]
proc = Proc.new do |obj, index, stop|
  p obj
  stop.assign(true) if index == 2
end
array.enumerateObjectsUsingBlock(proc)