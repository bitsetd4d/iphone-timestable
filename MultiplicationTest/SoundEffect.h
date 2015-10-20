//
//  SoundEffect.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 02/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundEffect : NSObject {
    SystemSoundID _soundID;
}

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath;
- (id)initWithContentsOfFile:(NSString *)path;
- (void)play;

@end
