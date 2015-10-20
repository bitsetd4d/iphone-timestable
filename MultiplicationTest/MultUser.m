//
//  MultUser.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 05/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MultUser.h"
#import "ImageUtilities.h"

@interface MultUser (Private)
- (void) updateDatabase;
- (void) insertNewRow;
- (void) updateExistingRow;
- (id) initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;
+ (void) readAllUsers;
+ (void) initializeDatabaseWithInitialUserData;
+ (void) currentUserPK: (NSInteger)pk;
+ (NSInteger) currentUserPK;

@end

@implementation MultUser

@synthesize primaryKey;
@synthesize name;
@synthesize image;
@synthesize inDatabase;

static sqlite3 *database;
static MultUser *currentUser = nil;
static NSMutableArray *allUsers = nil;

static sqlite3_stmt *select_statement = nil;
static sqlite3_stmt *update_statement = nil;
static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *delete_statement = nil;

+ (MultUser*)currentUser {
    @synchronized(self) {
        if (currentUser == nil) {
			NSInteger pk = [self currentUserPK];
			NSLog(@"Current User PK is %d",pk);
			@try {
				MultUser *user = [[MultUser alloc] initWithPrimaryKey:pk database:database];
				if (user.inDatabase) {
					NSLog(@"Current User %d is in database %@",pk,user.name);
					currentUser = user;	
				} else {
					NSLog(@"User not found in database ... picking another user..");
					MultUser *u = [allUsers objectAtIndex:0];
					[self currentUser:u];
				}
			} @catch (NSException *e) {
				NSLog(@"Exception getting current user %@ -- %@",e.name,e.reason);
				currentUser = [[self alloc] initWithDefaultValues];
			}
        }
    }
	NSLog(@"Returning current user %@, image size %f w x %f h",currentUser.name,currentUser.image.size.width,currentUser.image.size.height);
    return currentUser;
}

+(void) currentUser: (MultUser*)user {
	@synchronized(self) {
		if (currentUser != user) {
			[currentUser release];
			currentUser = [user retain];
			[self currentUserPK: user.primaryKey];
			NSLog(@"Setting current user to %@, pk=%d",user.name,user.primaryKey);
		}
	}
}

+(NSArray*) allUsers {
	if (allUsers == nil) {
		[self readAllUsers];
	}
	return [[allUsers copy] autorelease];
}

+(void) saveUserAndMakeCurrent: (MultUser*)user {
	[user updateDatabase];
	[self currentUserPK: user.primaryKey];
	[self currentUser: user];	
}

+ (void) initializeDatabase: (NSString *)path {
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
		//[self readAllUsers];
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }		
}
	
+ (void) readAllUsers {
	const char *sql = "SELECT pk FROM user";
	sqlite3_stmt *statement;
	BOOL empty = YES;
	NSLog(@"Reading all users from database"); 
	// Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
	// The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.        
	if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
		NSMutableArray *usersFromDb = [[NSMutableArray alloc] init];
		// We "step" through the results - once for each row.
		
		while (sqlite3_step(statement) == SQLITE_ROW) {
			// The second parameter indicates the column index into the result set.
			int primaryKey = sqlite3_column_int(statement, 0);
			MultUser *user = [[MultUser alloc] initWithPrimaryKey:primaryKey database:database];
			NSLog(@"Read %d from db, user is [%@,%d]",primaryKey,user.name,user.primaryKey);
			[usersFromDb addObject: user];
			[user release];
			empty = NO;
		}
		allUsers = usersFromDb;
	}
	// "Finalize" the statement - releases the resources associated with the statement.
	sqlite3_finalize(statement);
	if (empty) {
		NSLog(@"Database empty - initialising");
		[self initializeDatabaseWithInitialUserData];
	}
}

+ (void) initializeDatabaseWithInitialUserData {
	MultUser* user = [[MultUser alloc] initWithDefaultValues];
	[self currentUser: user];
	[user insertNewRow];
	[user release];
	[allUsers release];
	allUsers = nil;
}

// --------------------------
// Instance methods
// --------------------------
- (UIImage*)miniImage {
	if (miniImage == nil && image != nil) {
		miniImage = [ImageUtilities resizedImage: image size: CGRectMake(0.0,0.0,50.0,50.0)];
		[miniImage retain];
	}
	return miniImage;
}

-(void) setImage:(UIImage *)value {
    if (value != image) {
        [value retain];
        [image release];
        image = value;
		miniImage = nil;
    }
}

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db {
	if (self = [super init]) {
        primaryKey = pk;
		NSLog(@"Loading user with pk %d...",pk);
        // Compile the query for retrieving book data. See insertNewBookIntoDatabase: for more detail.
        if (select_statement == nil) {
            const char *sql = "SELECT name,image FROM user WHERE pk=?";
            if (sqlite3_prepare_v2(database, sql, -1, &select_statement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error: failed to prepare select statement with message '%s'.", sqlite3_errmsg(database));
            }
        }
        // Note that the parameters are numbered from 1, not from 0.
        sqlite3_bind_int(select_statement, 1, primaryKey);
        if (sqlite3_step(select_statement) == SQLITE_ROW) {
            self.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(select_statement, 0)];			
			int length = sqlite3_column_bytes(select_statement, 1);
			NSData *data = [NSData dataWithBytes:sqlite3_column_blob(select_statement, 1) length:length];
			self.image = [UIImage imageWithData:data];
			NSLog(@"Loading user with pk %d, name=%@, image size=%d",pk,name,image.size);
			inDatabase = YES;
        } else {
            self.name = @"Unknown";
			self.image = nil;
			inDatabase = NO;
        }
        // Reset the statement for future reuse.
        sqlite3_reset(select_statement);
    }
    return self;	
}
// Useful: http://www.naan.net/trac/browser/trunk/TwitterFon/Classes/ImageStore/ProfileImage.m?rev=719

- (void) updateDatabase {
	if (primaryKey == 0) {
		[self insertNewRow];
	} else {
		[self updateExistingRow];
	}	
	[allUsers release];
	allUsers = nil;
}

- (void) deleteFromDatabase {
	NSLog(@"Deleting user %@ (%d) from database",name,primaryKey);
	if (delete_statement == nil) {
		const char *sql = "delete from user where pk=?";
		if (sqlite3_prepare_v2(database, sql, -1, &delete_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare delete statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	sqlite3_bind_int(delete_statement, 1, primaryKey);
	int success = sqlite3_step(delete_statement);
	sqlite3_reset(delete_statement);
	// Handle errors.
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed in delete_statement with message '%s'.", sqlite3_errmsg(database));
	}
	currentUser = nil;
	[MultUser readAllUsers];
}

- (void) insertNewRow {
	if (insert_statement == nil) {
		const char *sql = "insert into user (name,image) values (?,?)";
		if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare insert statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	NSData *imageData = UIImagePNGRepresentation(image);
	NSLog(@"Inserting user pk=%d, name=%@, imagesize=%d bytes.",primaryKey,name,[imageData length]); 
	sqlite3_bind_text(insert_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_blob(insert_statement, 2, [imageData bytes]  , [imageData length], SQLITE_TRANSIENT);
	
	int success = sqlite3_step(insert_statement);
	// Reset the query for the next use.
	sqlite3_reset(insert_statement);
	// Handle errors.
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed in update_statement with message '%s'.", sqlite3_errmsg(database));
	}
	primaryKey = sqlite3_last_insert_rowid(database);
}

- (void) updateExistingRow {
	if (update_statement == nil) {
		const char *sql = "UPDATE user SET name=?, image=? where pk=?";
		if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare update statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	NSData *imageData = UIImagePNGRepresentation(image);
	NSLog(@"Updating row %d, Name=%@, ImageSize=%d",primaryKey,name,[imageData length]);
	sqlite3_bind_text(update_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_blob(update_statement, 2, [imageData bytes], [imageData length], SQLITE_TRANSIENT);
	sqlite3_bind_int(update_statement, 3, primaryKey);
	
	int success = sqlite3_step(update_statement);
	// Reset the query for the next use.
	sqlite3_reset(update_statement);
	// Handle errors.
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed in update_statement with message '%s'.", sqlite3_errmsg(database));
	}	
}

+(void) closeDatabase {
	sqlite3_finalize(select_statement);
	sqlite3_finalize(update_statement);
	sqlite3_finalize(insert_statement);
    if (sqlite3_close(database) != SQLITE_OK) {
        NSAssert1(0, @"Error: failed to close database with message '%s'.", sqlite3_errmsg(database));
    }	
}

+(NSInteger) currentUserPK {
	if ([[NSUserDefaults standardUserDefaults] integerForKey:@"currentUserPK"]) {
		return [[NSUserDefaults standardUserDefaults] integerForKey:@"currentUserPK"];
	} else { 
		return 1;
	}
}

+(void) currentUserPK: (NSInteger)pk {
	[[NSUserDefaults standardUserDefaults] setInteger:pk forKey:@"currentUserPK"];
}


- (id)copyWithZone:(NSZone *)zone {
	MultUser *copy = [[MultUser alloc] init];
	copy.name = name;
	copy.image = image;
	copy->primaryKey = primaryKey;
	copy->inDatabase = inDatabase;
	return copy;
}

- (id) initWithDefaultValues {
	self.name = @"You";
	primaryKey = 0;
	return self;	
}

@end
