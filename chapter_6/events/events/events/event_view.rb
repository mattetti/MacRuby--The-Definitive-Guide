class EventView < NSView
  
  def acceptsFirstResponder
    true
  end
  
  def keyDown(event)
    puts "key down"
    characters = event.characters
    if characters.length == 1 && !event.isARepeat
      character = characters.characterAtIndex(0)
      case character
        when NSLeftArrowFunctionKey
        puts "you pressed the left arrow"
        when NSRightArrowFunctionKey
        puts "you pressed the right arrow"
      end
    end
  end
  
end