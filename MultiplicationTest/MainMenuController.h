//
//  MainMenuController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 29/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainingHelpController.h"
#import "ChallengeHelpController.h"
#import "MyControllerLoader.h"
#import "TestMeHelpController.h"
#import "UserController.h"

@interface MainMenuController : UIViewController {
	
	IBOutlet UIButton *imageButton;
	UINavigationController *userNavigationController;
	UserController *userController;
	
	TrainingHelpController *trainingHelpController;
	ChallengeHelpController *challengeHelpController;
	TestMeHelpController *testMeHelpController;
	
}
@property (nonatomic, retain) UIButton *imageButton;
@property (nonatomic, retain) UINavigationController *userNavigationController;
@property (nonatomic, retain) UserController *userController;
@property (nonatomic, retain) TrainingHelpController *trainingHelpController;
@property (nonatomic, retain) ChallengeHelpController *challengeHelpController;
@property (nonatomic, retain) TestMeHelpController *testMeHelpController;

- (IBAction)switchToUserView;

- (IBAction)switchToTrainingView;
- (IBAction)switchToTestMeView;
- (IBAction)switchToChallengeView;

- (IBAction)switchToHelpView;

@end
