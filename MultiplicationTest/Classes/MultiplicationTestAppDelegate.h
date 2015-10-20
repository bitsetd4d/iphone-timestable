//
//  MultiplicationTestAppDelegate.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 28/12/2008.
//  Copyright D3BUG Software Ltd 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

#import "MainMenuController.h"

@interface MultiplicationTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainMenuController *mainMenuController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainMenuController *mainMenuController;

@end

