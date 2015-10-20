//
//  TestMeChooseController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestMeTestController.h"

@interface TestMeChooseController : UIViewController {

	TestMeTestController *testMeController;
	
}

@property (nonatomic, retain) TestMeTestController *testMeController;

- (IBAction)proceedToTest;
- (IBAction)closeView;

@end
