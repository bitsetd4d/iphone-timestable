//
//  MyControllerLoader.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 29/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import "MyControllerLoader.h"
#import "TrainingHelpController.h"
#import "TrainingViewController.h"

#import "ChallengeHelpController.h"
#import "ChallengeChooseController.h"
#import "ChallengeTestController.h"
#import "ChallengeScoreController.h"

#import "TestMeChooseController.h"
#import "TestMeHelpController.h"
#import "TestMeTestController.h"
#import "TestMeScoreController.h"

#import "UserController.h"
#import "ChangeUserController.h"
#import "EditUserController.h"

@implementation MyControllerLoader

// TODO these 'allocs' shouldn't autorelease

+ (id)allocTrainingHelpController {
	return [[[TrainingHelpController alloc] initWithNibName:@"TrainingHelp" bundle:nil] autorelease];
}

+ (id)allocTrainingViewController {
	return [[[TrainingViewController alloc] initWithNibName:@"Training" bundle:nil] autorelease];
}

+ (id)allocChallengeHelpController {
	return [[[ChallengeHelpController alloc] initWithNibName:@"ChallengeHelp" bundle:nil] autorelease];
}

+ (id)allocChallengeChooseController {
	return [[[ChallengeChooseController alloc] initWithNibName:@"ChallengeChoose" bundle:nil] autorelease];
}

+ (id)allocChallengeTestController {
	return [[[ChallengeTestController alloc] initWithNibName:@"ChallengeTest" bundle:nil] autorelease];
}

+ (id)allocChallengeScoreController {
	return [[[ChallengeScoreController alloc] initWithNibName:@"ChallengeScore" bundle:nil] autorelease];
}

+ (id)allocTestMeHelpController {
	return [[[TestMeHelpController alloc] initWithNibName:@"TestMeHelp" bundle:nil] autorelease];
}

+ (id)allocTestMeChooseController {
	return [[[TestMeChooseController alloc] initWithNibName:@"TestMeChoose" bundle:nil] autorelease];
}

+ (id)allocTestMeTestController {
	return [[[TestMeTestController alloc] initWithNibName:@"TestMeTest" bundle:nil] autorelease];
}

+ (id)allocTestMeScoreController {
	return [[[TestMeScoreController alloc] initWithNibName:@"TestMeScore" bundle:nil] autorelease];
}

+ (id)allocUserController {
	UserController *controller = [[[UserController alloc] initWithNibName:@"User" bundle:nil] autorelease];
	controller.navigationItem.title = @"User";
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone
																	 target:controller action:@selector(userDone:)];
	controller.navigationItem.rightBarButtonItem = anotherButton;
	return controller;
}

+ (id)allocChangeUserController {
	return [[ChangeUserController alloc] initWithNibName:@"ChangeUser" bundle:nil];
}

+ (id)allocAddUserController {
	return [[[AddUserController alloc] initWithNibName:@"AddUserUser" bundle:nil] autorelease];
}

+ (id)allocEditUserController {
	return [[[EditUserController alloc] initWithNibName:@"EditUser" bundle:nil] autorelease];
}

+ (void)setCurrentViewFromController:(UIViewController*)controller onView:(UIView*)parentView { 
	UIView *view = controller.view;    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.5f];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView: parentView cache:YES];
	[parentView addSubview: view];
	[UIView commitAnimations];
}

+ (void)closeView:(UIView*)theView {	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2.5f];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:theView.superview cache:YES];
	[theView removeFromSuperview];
	[UIView commitAnimations];		
}

+ (void)backupToView:(UIView*)stopView fromView:(UIView*)fromView speed:(NSTimeInterval)speed {
	
	UIView *view = fromView;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:speed];
	
	while (view != nil && view != stopView) {
		UIView *parent = [view superview];
		[view removeFromSuperview];
		view = parent;
	}
	
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView: stopView cache:YES];
	[UIView commitAnimations];		
}

@end
