require 'rubygems'
require 'nokogiri'

class AppDelegate
  attr_accessor :window
  def applicationDidFinishLaunching(a_notification)
    nokogiri_example
  end
  
  def nokogiri_example
    xml = "
    <root>
      <shows>
        <show>
          <name>Battlestar Galactica - 2004</name>
            <characters>
            <character species='human'>William Adama</character>
            <character species='human'>Laura Roslin</character>
            <character species='human'>Kara 'Starbuck' Thrace</character>
            <character species='human'>Lee 'Apollo' Adama</character>
            <character species='human'>Dr. Gaius Baltar</character>
            <character species='cylon'>Number Six</character>
            <character species='cylon'>Number Eight</character>
          </characters>
        </show>
      </shows>
    </root>"
    
    # Parse the XML string
    xml_obj  = Nokogiri::XML(xml)
    
    # find all characters using xpath and extract the node contents in an array
    all_characters = xml_obj.xpath("//characters/character").map(&:content)
    puts "BSG main characters: #{all_characters}"
    # => BSG characters: ["William Adama", "Laura Roslin", "Kara 'Starbuck' Thrace", 
    # "Lee 'Apollo' Adama", "Dr. Gaius Baltar", "Number Six", "Number Eight"]
    
    # Now do the same but filter the cylons using the species attribute.
    cylons = xml_obj.xpath("//characters/character[@species='cylon']").map(&:content)
    puts "Cylons: #{cylons}" 
    # => Cylons: ["Number Six", "Number Eight"]
  end
end