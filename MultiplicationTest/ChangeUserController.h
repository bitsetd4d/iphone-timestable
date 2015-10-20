//
//  ChangeUserController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddUserController.h"
#import "EditUserController.h"

@interface ChangeUserController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
	
	EditUserController *editUserController;
	IBOutlet UITableView *tableView;
	
	NSArray *userList;

}

@property (nonatomic,retain) EditUserController *editUserController;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSArray *userList;

@end
