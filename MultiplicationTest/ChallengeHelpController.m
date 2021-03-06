//
//  ChallengeHelpController.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import "ChallengeHelpController.h"
#import "MyControllerLoader.h"


@implementation ChallengeHelpController

@synthesize challengeChooseController;

- (IBAction)proceedToChallenge {
	if (challengeChooseController == nil) {
		self.challengeChooseController = [MyControllerLoader allocChallengeChooseController];
	}
	[MyControllerLoader setCurrentViewFromController:challengeChooseController onView:self.view.superview];
	[self.view removeFromSuperview];
}

- (IBAction)closeView {
	[MyControllerLoader closeView: self.view];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	[challengeChooseController release];
    [super dealloc];
}


@end
