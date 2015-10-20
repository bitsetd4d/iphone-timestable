//
//  EditUserController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 15/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultUser.h"

@interface EditUserController : UIViewController<UITableViewDataSource,UITableViewDelegate,
	UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate> {  

	MultUser *editingUser;
	
	IBOutlet UITableView *tableView;
	IBOutlet UIView *headerView;
	IBOutlet UIButton *imageButton;
	
	UIImagePickerController *imagePickerController;
	BOOL askingAboutDelete;

}

@property (nonatomic,copy) MultUser *editingUser;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIButton *imageButton;

- (IBAction)changePhoto;

@end
