//
//  MainMenuLabel.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 01/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLabel.h"


@implementation MainMenuLabel

@synthesize label;

- (void)init {
	firstRun = YES;
}

- (void)animateWithId:(int)numberId {
	if (inMotion == YES) return;
	CGFloat newX = rand() % 320;
	CGFloat newY = -20 - rand() % 80;
	if (firstRun == YES) {
		newX = label.center.x;
		newY = label.center.y;	
		firstRun = NO;
	}
	CGFloat rotation = -3.0 + (rand() % 600) / 100.0;
	CGFloat duration = 2.0 +  (rand() % 300) / 100.0; 
	label.center = CGPointMake(newX,newY);
	label.transform = CGAffineTransformMakeRotation(0);

	inMotion = YES;
	NSString *id = [NSString stringWithFormat: @"%d",numberId];
	[UIView beginAnimations:id context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseIn];
	label.center = CGPointMake(newX,520);
	label.transform = CGAffineTransformMakeRotation(rotation);
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDidStopSelector:@selector(animationStopped:finished:context:)];
	[UIView commitAnimations];	
}

- (void)animationStopped:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	inMotion = NO;
}

- (void)dealloc {
	[label release];
	[super dealloc];
}

@end
