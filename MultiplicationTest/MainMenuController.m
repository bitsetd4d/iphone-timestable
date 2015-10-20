//
//  MainMenuController.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 29/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import "MainMenuController.h"
#import "ScreenFlow.h"

@interface MainMenuController (PrivateMethods)
- (void)stopLetterAnimation;
@end

@implementation MainMenuController

@synthesize userController;
@synthesize userNavigationController;
@synthesize trainingHelpController;
@synthesize challengeHelpController;
@synthesize testMeHelpController;
@synthesize imageButton;


- (IBAction)switchToUserView {
	[[ScreenFlow instance] gotoChangeOrAddUser];
}

- (IBAction)switchToTrainingView {
	if (trainingHelpController == nil) {
		self.trainingHelpController = [MyControllerLoader allocTrainingHelpController];
	}
	[MyControllerLoader setCurrentViewFromController: trainingHelpController onView:self.view];
}

- (IBAction)switchToTestMeView {
	if (testMeHelpController == nil) {
		self.testMeHelpController = [MyControllerLoader allocTestMeHelpController];
	}
	[MyControllerLoader setCurrentViewFromController: testMeHelpController onView:self.view];
}

- (IBAction)switchToChallengeView {
	if (challengeHelpController == nil) {
		self.challengeHelpController = [MyControllerLoader allocChallengeHelpController];
	}
	[MyControllerLoader setCurrentViewFromController: challengeHelpController onView:self.view];
}

- (IBAction)switchToHelpView {
	
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	NSLog(@"MainMenuController - viewDidAppear:");
	[imageButton setBackgroundImage:[MultUser currentUser].image forState: UIControlStateNormal];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[userController release];
	[userNavigationController release];
	[trainingHelpController release];
	[challengeHelpController release];
	[testMeHelpController release];
    [super dealloc];
}


@end
