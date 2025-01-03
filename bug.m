In Objective-C, a common yet subtle error arises when dealing with `NSManagedObjectContext` and its interaction with threads.  Specifically, attempting to save changes to the context from a thread other than the one on which it was created can lead to unexpected crashes or data corruption.  The following code demonstrates this:

```objectivec
// Incorrect - Saving the context from a background thread
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
    [self.managedObjectContext save:&error]; // Crash or data corruption likely
});
```