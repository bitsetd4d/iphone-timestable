//
//  MyControllerLoader.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 29/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyControllerLoader : NSObject {

}

+ (id)allocTrainingHelpController;
+ (id)allocTrainingViewController;

+ (id)allocChallengeHelpController;
+ (id)allocChallengeChooseController;
+ (id)allocChallengeTestController;
+ (id)allocChallengeScoreController;

+ (id)allocTestMeHelpController;
+ (id)allocTestMeChooseController;
+ (id)allocTestMeTestController;
+ (id)allocTestMeScoreController;

+ (id)allocUserController;
+ (id)allocChangeUserController;
+ (id)allocAddUserController;
+ (id)allocEditUserController;

+ (void)setCurrentViewFromController:(UIViewController*)controller onView:(UIView*)parentView;
+ (void)closeView:(UIView*)theView;
+ (void)backupToView:(UIView*)stopView fromView:(UIView*)fromView speed:(NSTimeInterval)speed;

@end
