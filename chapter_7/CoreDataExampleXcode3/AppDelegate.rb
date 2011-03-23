#
# AppDelegate.rb
# CoreDataExample
#
# Created by Matt Aimonetti on 1/1/11.
# Copyright m|a agile 2011. All rights reserved.
#

class AppDelegate
  # The default template uses an attribute writer.
  # We want an attribute accessor instead.
  # attr_writer :window
  
  # custom accessor
  attr_accessor :window
  attr_accessor :movies

  # Returns the support folder for the application, used to store the Core Data
  # store file.  This code uses a folder named "CoreDataExample" for
  # the content, either in the NSApplicationSupportDirectory location or (if the
  # former cannot be found), the system's temporary directory.
  def applicationSupportFolder
    paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, true)
    basePath = paths[0] || NSTemporaryDirectory()
    basePath.stringByAppendingPathComponent("CoreDataExample")
  end

  # Creates and returns the managed object model for the application 
  # by merging all of the models found in the application bundle.
  def managedObjectModel
    @managedObjectModel ||= NSManagedObjectModel.mergedModelFromBundles(nil)
  end


  # Returns the persistent store coordinator for the application.  This 
  # implementation will create and return a coordinator, having added the 
  # store for the application to it.  (The folder for the store is created, 
  # if necessary.)
  def persistentStoreCoordinator
    unless @persistentStoreCoordinator
      error = Pointer.new_with_type('@')
    
      fileManager = NSFileManager.defaultManager
      applicationSupportFolder = self.applicationSupportFolder
    
      unless fileManager.fileExistsAtPath(applicationSupportFolder, isDirectory:nil)
        fileManager.createDirectoryAtPath(applicationSupportFolder, attributes:nil)
      end
    
      url = NSURL.fileURLWithPath(applicationSupportFolder.stringByAppendingPathComponent("CoreDataExample.xml"))
      @persistentStoreCoordinator = NSPersistentStoreCoordinator.alloc.initWithManagedObjectModel(self.managedObjectModel)
      unless @persistentStoreCoordinator.addPersistentStoreWithType(NSXMLStoreType, configuration:nil, URL:url, options:nil, error:error)
        NSApplication.sharedApplication.presentError(error[0])
      end
    end

    @persistentStoreCoordinator
  end

  # Returns the managed object context for the application (which is already
  # bound to the persistent store coordinator for the application.) 
  def managedObjectContext
    unless @managedObjectContext
      coordinator = self.persistentStoreCoordinator
      if coordinator
        @managedObjectContext = NSManagedObjectContext.new
        @managedObjectContext.setPersistentStoreCoordinator(coordinator)
      end
    end
    
    @managedObjectContext
  end

  # Returns the NSUndoManager for the application.  In this case, the manager
  # returned is that of the managed object context for the application.
  def windowWillReturnUndoManager(window)
    self.managedObjectContext.undoManager
  end

  # Performs the save action for the application, which is to send the save:
  # message to the application's managed object context.  Any encountered errors
  # are presented to the user.
  def saveAction(sender)
    error = Pointer.new_with_type('@')
    unless self.managedObjectContext.save(error)
      NSApplication.sharedApplication.presentError(error[0])
    end
  end

  # Implementation of the applicationShouldTerminate: method, used here to
  # handle the saving of changes in the application managed object context
  # before the application terminates.
  def applicationShouldTerminate(sender)
    error = Pointer.new_with_type('@')
    reply = NSTerminateNow
    
    if managedObjectContext
      if managedObjectContext.commitEditing
        if managedObjectContext.hasChanges && (not managedObjectContext.save(error))
          # This error handling simply presents error information in a panel with an 
          # "Ok" button, which does not include any attempt at error recovery (meaning, 
          # attempting to fix the error.)  As a result, this implementation will 
          # present the information to the user and then follow up with a panel asking 
          # if the user wishes to "Quit Anyway", without saving the changes.

          # Typically, this process should be altered to include application-specific 
          # recovery steps.  
          
          errorResult = NSApplication.sharedApplication.presentError(error[0])
          
          if errorResult
            reply = NSTerminateCancel
          else
            alertReturn = NSRunAlertPanel(nil, "Could not save changes while quitting. Quit anyway?" , "Quit anyway", "Cancel", nil)
            if alertReturn == NSAlertAlternateReturn
              reply = NSTerminateCancel
            end
          end
        end
      else
        reply = NSTerminateCancel
      end
    end
    
    reply
  end
  
  ####### Added code #######
  
  # Action called by the menu and a button
  # to create add a movie image.
  # The file gets copied over to the support folder
  # and never gets cleaned up ;)
  def add_image(sender)
    movie = movies.selectedObjects.lastObject
    return if movie.nil?
    panel = NSOpenPanel.openPanel
    panel.canChooseDirectories = false
    panel.canCreateDirectories = false
    panel.allowsMultipleSelection = false
       
    panel.beginSheetModalForWindow window, completionHandler: Proc.new{|result|
      return if (result == NSCancelButton) 
      path = panel.filename
      dest_path = applicationSupportFolder

      # use a GUID to avoid conflicts
      guid = NSProcessInfo.processInfo.globallyUniqueString
      # set the destination path in the support folder
      dest_path = "#{dest_path}/#{guid}"
      error = Pointer.new(:id)
      NSFileManager.defaultManager.copyItemAtPath(path, toPath:dest_path, error:error)
      NSApp.presentError(error) if error[0]
      movie.setValue(dest_path, forKey:"imagePath")
    }
    
  end

end
