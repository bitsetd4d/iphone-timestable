//
//  TrainingHelpController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 29/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainingViewController.h"

@interface TrainingHelpController : UIViewController {

	TrainingViewController *trainingViewController;
	
}
@property (nonatomic, retain) TrainingViewController *trainingViewController;

- (IBAction)switchToTrainingView;
- (IBAction)closeView;

@end
