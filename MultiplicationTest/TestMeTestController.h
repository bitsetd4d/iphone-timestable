//
//  TestMeTestController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestMeScoreController.h"

@interface TestMeTestController : UIViewController {
	
	TestMeScoreController *testMeScoreController;

}
@property (nonatomic, retain) TestMeScoreController *testMeScoreController;

- (IBAction)challengeCompleted;

@end
