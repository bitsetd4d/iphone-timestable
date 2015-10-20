//
//  UserController.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "UserController.h"
#import "MyControllerLoader.h"
#import "MultUser.h"
#import "ScreenFlow.h"

@implementation UserController

@synthesize nameLabel;
@synthesize imageButton;

- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *changeButton = [[[UIBarButtonItem alloc] 
									  initWithTitle: @"Switch" style: UIBarButtonItemStylePlain target:self action:@selector(changeUser:)] autorelease];
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc]
									  initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(userDone:)] autorelease];
	self.navigationItem.rightBarButtonItem = changeButton;
	self.navigationItem.leftBarButtonItem = doneButton;
	
	self.navigationItem.title = @"User";

}

- (void)changeUser: sender {
	[[ScreenFlow instance] gotoChangeUser];
}

- (void)editUser: sender {
	[[ScreenFlow instance] gotoEditUser:[MultUser currentUser]];
}

- (IBAction)userDone:(id)sender {	
	[[ScreenFlow instance] backup];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear: animated];
	MultUser *user = [MultUser currentUser];
	nameLabel.text = user.name;
	[imageButton setBackgroundImage:user.image forState: UIControlStateNormal];
	self.navigationItem.prompt = [NSString stringWithFormat: @"Hello %@", [user name]];
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
	//[changeUserController release];
    [super dealloc];
}


@end
