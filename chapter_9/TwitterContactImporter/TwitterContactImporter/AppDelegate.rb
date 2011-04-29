#
#  AppDelegate.rb
#  TwitterContactImporter
#
#  Created by Matt Aimonetti on 4/28/11.
#  Copyright 2011 m|a agile Consulting. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  attr_reader :address_book
  
  def applicationDidFinishLaunching(a_notification)
    @address_book = ABAddressBook.sharedAddressBook
    check_me
  end
  
  def alert(title='Alert', message='Something went wrong :(')
    NSAlert.alertWithMessageText(title, 
                                 defaultButton: 'OK',
                                 alternateButton: nil, 
                                 otherButton: nil,
                                 informativeTextWithFormat: message).runModal
  end
  
  def check_me
    unless address_book.me
      alert "Address Book Problem",
      "You need to open the Address Book and mark a contact as yours. Choose a contact, click on Card and select 'Make this my card'."
    end
  end
  
  def windowWillClose(sender); exit; end
end