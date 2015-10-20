//
//  ChallengeHelpController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengeChooseController.h"


@interface ChallengeHelpController : UIViewController {

	ChallengeChooseController *challengeChooseController;
	
}

@property (nonatomic, retain) ChallengeChooseController *challengeChooseController;

- (IBAction)proceedToChallenge;
- (IBAction)closeView;

@end
