//
//  ImageUtilities.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 14/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageUtilities : NSObject {

}
	
+ (UIImage*)resizedImage: (UIImage*)inImage size: (CGRect)thumbRect;

@end
