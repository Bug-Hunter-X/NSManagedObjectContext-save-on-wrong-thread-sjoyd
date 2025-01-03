The correct approach involves using `performBlockAndWait:` on the context's queue or creating a separate context for background operations:

```objectivec
// Correct - Using performBlockAndWait:
[self.managedObjectContext performBlockAndWait:^{ 
    NSError *error = nil; 
    if (![self.managedObjectContext save:&error]) { 
        NSLog("Error saving context: %@
", error);
    }
}];

// Or, better yet, a separate background context:
NSManagedObjectContext *backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
[backgroundContext setParentContext:self.managedObjectContext];

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
    [backgroundContext performBlock:^{ 
        NSError *error = nil;
        if (![backgroundContext save:&error]) {
            NSLog("Error saving background context: %@
", error);
        } else {
            [self.managedObjectContext performBlock:^{ 
                NSError *error = nil; 
                if (![self.managedObjectContext save:&error]) { 
                    NSLog("Error saving main context: %@
", error);
                }
            }];
        }
    }];
});
```
Using a separate background context is generally preferred for better performance and thread safety.