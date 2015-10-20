//
//  UserController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeUserController.h"


@interface UserController : UIViewController {
		
	IBOutlet UILabel *nameLabel;
	IBOutlet UIButton *imageButton;

}

@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UIButton *imageButton;

- (IBAction)editUser:(id)sender;
- (IBAction)userDone:(id)sender;

@end
