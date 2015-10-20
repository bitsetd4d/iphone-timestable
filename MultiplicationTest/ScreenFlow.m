//
//  ScreenFlow.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 23/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ScreenFlow.h"

static ScreenFlow *instance;

@implementation ScreenFlow

@synthesize mainMenuController;
@synthesize userController;
@synthesize editUserController;
@synthesize userNavigationController;
@synthesize currentController;

+ (ScreenFlow*)instance {
	 @synchronized(self) {
		 if (instance == nil) {
			 instance = [[ScreenFlow alloc] init];
		 }
	 }
	return instance;
}

- (void)initialise:(UIWindow*)theWindow {
	window = theWindow;
	mainMenuController = [[MainMenuController alloc] initWithNibName:@"MainMenu" bundle:nil]; 
	UIView *theView = [mainMenuController view];
	self.currentController = mainMenuController;
    [window addSubview: theView];
    [window makeKeyAndVisible];
}

#pragma mark -
#pragma mark Main Menu
- (void)gotoMainMenu {
}
#pragma mark -
#pragma mark Change User flows
		
- (void)gotoChangeOrAddUser {
	if (userController == nil) { self.userController = [MyControllerLoader allocUserController]; }
	if (userNavigationController == nil) { 
		self.userNavigationController = [[UINavigationController alloc] initWithRootViewController:userController];
	}
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView: window cache:YES];
	[window addSubview: userNavigationController.view];
	
	//[self.view addSubview: userNavigationController.view];
	[UIView commitAnimations];	
	[userController viewDidAppear: YES];
}

- (void)gotoChangeUser {	
	ChangeUserController *controller = [MyControllerLoader allocChangeUserController];
	[userNavigationController pushViewController:controller animated:YES];
	[controller viewDidAppear: YES];	
	[controller release];
}

- (void)gotoEditUser:(MultUser*)user {
	if (editUserController == nil) {
		self.editUserController = [MyControllerLoader allocEditUserController];
	}
	editUserController.editingUser = user;
	editUserController.editing = YES;  
	UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:editUserController];
	[userNavigationController presentModalViewController:navControl animated:YES];
	[navControl release];
}

#pragma mark -
#pragma mark Defunct?
- (void)push:(UIViewController*)controller {
}

- (void)backup {
	if ([userNavigationController.viewControllers count] > 1) {
		[userNavigationController popViewControllerAnimated: YES];		
	} else {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:2.0];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView: userNavigationController.view.superview cache:YES];
		[userNavigationController.view removeFromSuperview];
		[UIView commitAnimations];	
		[mainMenuController viewDidAppear: YES];
	}
}

@end
