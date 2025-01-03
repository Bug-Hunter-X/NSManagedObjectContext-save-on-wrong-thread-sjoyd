# Objective-C NSManagedObjectContext Threading Issue

This repository demonstrates a common error in Objective-C related to using `NSManagedObjectContext` on incorrect threads.  Attempting to save changes to the context from a background thread can result in crashes or data corruption.

The `bug.m` file contains code that incorrectly attempts to save the context from a background thread. The `bugSolution.m` file shows the correct way to handle this using performBlockAndWait or a dedicated context for background threads. 