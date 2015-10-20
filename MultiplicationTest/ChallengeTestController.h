//
//  ChallengeTestController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengeScoreController.h"


@interface ChallengeTestController : UIViewController {

	ChallengeScoreController *challengeScoreController;
	
}

@property (nonatomic, retain) ChallengeScoreController *challengeScoreController;

- (IBAction)challengeCompleted;

@end
