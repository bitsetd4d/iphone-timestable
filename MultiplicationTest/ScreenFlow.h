//
//  ScreenFlow.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 23/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainMenuController.h"
#import "UserController.h"
#import "EditUserController.h"
#import "MultUser.h"

@interface ScreenFlow : NSObject {
	MainMenuController *mainMenuController;
	UserController *userController;
	EditUserController *editUserController;
	UINavigationController *userNavigationController;
	UIWindow *window;
	
	UIViewController *currentController;
}

@property (nonatomic,retain) MainMenuController *mainMenuController;
@property (nonatomic,retain) UserController *userController;
@property (nonatomic,retain) EditUserController *editUserController;
@property (nonatomic,retain) UINavigationController *userNavigationController;
@property (nonatomic,retain) UIViewController *currentController;

+ (ScreenFlow*)instance;

- (void)initialise:(UIWindow*)window;
- (void)gotoMainMenu;
- (void)gotoChangeOrAddUser;
- (void)gotoChangeUser;
- (void)gotoEditUser:(MultUser*)user;
- (void)push:(UIViewController*)controller;
- (void)backup;

@end
