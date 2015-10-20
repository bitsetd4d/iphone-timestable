//
//  ImageUtilities.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 14/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageUtilities.h"

@implementation ImageUtilities

// http://www.iphonedevsdk.com/forum/iphone-sdk-development/5204-resize-image-high-quality.html

+ (UIImage*)resizedImage: (UIImage*)inImage size: (CGRect)thumbRect {
	NSLog(@"Resizing image to %f x %f",thumbRect.size.width,thumbRect.size.height);
	CGImageRef imageRef = [inImage CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	
	// There's a wierdness with kCGImageAlphaNone and CGBitmapContextCreate
	// see Supported Pixel Formats in the Quartz 2D Programming Guide
	// Creating a Bitmap Graphics Context section only RGB 8 bit images with alpha of
	
	// kCGImageAlphaNoneSkipFirst, 
	// kCGImageAlphaNoneSkipLast, 
	// kCGImageAlphaPremultipliedFirst,
	// and kCGImageAlphaPremultipliedLast, 
	
	// with a few other oddball image kinds are supported
	// The images on input here are likely to be png or jpeg files
	if (alphaInfo == kCGImageAlphaNone) alphaInfo = kCGImageAlphaNoneSkipLast;
	
	alphaInfo = kCGImageAlphaNoneSkipFirst; //  Just make it this...
	
	// Build a bitmap context that's the size of the thumbRect
	CGContextRef bitmap = CGBitmapContextCreate(
			NULL,
			thumbRect.size.width,
			thumbRect.size.height,
			CGImageGetBitsPerComponent(imageRef),   // really needs to always be 8
			4 * thumbRect.size.width,				// rowbytes
			CGImageGetColorSpace(imageRef),
			alphaInfo);
	
	// Draw into the context, this scales the image
	CGContextDrawImage(bitmap, thumbRect, imageRef);
	
	// Get an image from the context and a UIImage
	CGImageRef        ref = CGBitmapContextCreateImage(bitmap);
	UIImage*          result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);           // ok if NULL
	CGImageRelease(ref);
	
	return result;
}



@end
