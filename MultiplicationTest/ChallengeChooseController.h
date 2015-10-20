//
//  ChallengeChooseController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengeTestController.h"


@interface ChallengeChooseController : UIViewController {
	
	ChallengeTestController *challengeTestController;

}

@property (nonatomic, retain) ChallengeTestController *challengeTestController;

- (IBAction)proceedToChallenge;
- (IBAction)closeView;

@end
