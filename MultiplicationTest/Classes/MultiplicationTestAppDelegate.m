//
//  MultiplicationTestAppDelegate.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 28/12/2008.
//  Copyright D3BUG Software Ltd 2008. All rights reserved.
//

#import "MultiplicationTestAppDelegate.h"
#import "ScreenFlow.h"

#define DB_NAME @"mult_db.sqlite"

@interface MultiplicationTestAppDelegate (Private)
- (NSString*)createEditableCopyOfDatabaseIfNeeded;
@end

@implementation MultiplicationTestAppDelegate

@synthesize window;
@synthesize mainMenuController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	NSString *location = [self createEditableCopyOfDatabaseIfNeeded];
    [MultUser initializeDatabase: location];	
	[[ScreenFlow instance] initialise:window]; 
}


- (void)dealloc {
    [mainMenuController release];
    [window release];
    [super dealloc];
}

// Creates a writable copy of the bundled default database in the application Documents directory.
- (NSString*)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return writableDBPath;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
	return writableDBPath;
}


// Save all changes to the database, then close it.
- (void)applicationWillTerminate:(UIApplication *)application {
	[MultUser closeDatabase];
}

@end
