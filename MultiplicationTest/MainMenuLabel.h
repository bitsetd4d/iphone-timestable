//
//  MainMenuLabel.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 01/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MainMenuLabel : NSObject {

	UILabel *label;
	BOOL inMotion;	
	BOOL firstRun;
}

@property (nonatomic,retain) UILabel *label;

- (void)animateWithId:(int)id;

@end
