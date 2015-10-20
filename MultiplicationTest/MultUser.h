//
//  MultUser.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 05/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface MultUser : NSObject<NSCopying> {
	
	NSInteger primaryKey;
	NSString *name;
	UIImage *image;
	UIImage *miniImage;
	BOOL inDatabase;

}
@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (assign, nonatomic, readonly) BOOL inDatabase;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,retain) UIImage *image;
@property (nonatomic,readonly) UIImage *miniImage;

+(MultUser*) currentUser;
+(void) currentUser: (MultUser*)user;
+(NSArray*) allUsers;

+(void) saveUserAndMakeCurrent: (MultUser*)user;
+(void) initializeDatabase: (NSString*)location;
+(void) closeDatabase;

-(id) initWithDefaultValues;
-(void) deleteFromDatabase;

@end
