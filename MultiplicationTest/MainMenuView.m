//
//  MainMenuView.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 29/12/2008.
//  Copyright 2008 D3BUG Software Ltd. All rights reserved.
//

#import "MainMenuView.h"
#import "MainMenuLabel.h"

@interface MainMenuView (PrivateMethods)
- (void)setupSubviews;
- (void)setupSounds;
@end

@implementation MainMenuView

@synthesize numberLabels;

- (id)initWithCoder:(NSCoder *)coder {
	if (self = [super initWithCoder:coder]) {
        // Initialization code
		[self setupSubviews];
		[self setupSounds];
		initialSubviewCount = self.subviews.count;
		[NSTimer scheduledTimerWithTimeInterval: 1.0
										 target: self
									   selector: @selector(handleAnimationTimer:)
									   userInfo: nil
										repeats: YES];	
    }
    return self;
}

- (void)setupSounds {
    NSBundle *mainBundle = [NSBundle mainBundle];
    tickSound = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"tick" ofType:@"caf"]];
}

- (void)setupSubviews {
	self.numberLabels = [[[NSMutableArray alloc] init] autorelease];
	// Number dealy
	srand(10000);
	for (int i=0; i<10; i++) {
		float x = rand() % 320;
		float y = rand() % 460;
		CGRect rect = CGRectMake(x , y, 100.0f, 100.0f);
		UILabel *label = [[[UILabel alloc] initWithFrame:rect] autorelease];
		label.text = [NSString stringWithFormat: @"%d", 1 + rand() % 9];
		label.opaque = NO;
		label.backgroundColor = [UIColor clearColor];
		label.alpha = (rand() % 300) / 1000.0f;
		label.font = [UIFont boldSystemFontOfSize: (10 + (rand() % 100))];
		label.textAlignment = UITextAlignmentCenter;
		
		MainMenuLabel *mlabel = [[MainMenuLabel alloc] init];
		mlabel.label = label;		
		[self.numberLabels addObject: mlabel]; 
		[mlabel release];
		[self addSubview: label];
		[self sendSubviewToBack: label];
	}
	// Character
	UIImageView *character = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sample_cartoon_pngcrushed.png"]] autorelease];
	character.center = CGPointMake(60,300);
	character.opaque = NO;
	[self addSubview: character];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)handleAnimationTimer:(NSTimer*)theTimer {
	if (initialSubviewCount != self.subviews.count) {
		return;
	}
	//[tickSound play];	
	for (int c = 0; c < numberLabels.count; c++) {
		MainMenuLabel *mmlabel = [numberLabels objectAtIndex:c];
		[mmlabel animateWithId:c];
	}
}

- (void)dealloc {
	[numberLabels release];
	[tickSound release];
    [super dealloc];
}


@end
