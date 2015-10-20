//
//  TestMeHelpController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestMeChooseController.h"


@interface TestMeHelpController : UIViewController {
	
	TestMeChooseController *chooseController;

}

@property (nonatomic, retain) TestMeChooseController *chooseController;

- (IBAction)proceedToTest;
- (IBAction)closeView;

@end
