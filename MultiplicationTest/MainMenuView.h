//
//  MainMenuView.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 29/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SoundEffect.h"


@interface MainMenuView : UIView {
	
	NSMutableArray *numberLabels;
	
	SoundEffect *tickSound;
	int index;
	int initialSubviewCount;

}
@property (nonatomic,retain) NSMutableArray *numberLabels;

@end
