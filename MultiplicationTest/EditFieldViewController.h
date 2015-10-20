//
//  EditFieldViewController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 18/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultUser.h"

@interface EditFieldViewController : UIViewController<UITextFieldDelegate> {

	IBOutlet MultUser *user;
	IBOutlet UITextField *textField;
	UIBarButtonItem *saveButton;
	
}

@property (nonatomic,retain) MultUser *user;
@property (nonatomic,retain) UITextField *textField;
@property (nonatomic,retain) UIBarButtonItem *saveButton;

- (IBAction)dismissEdit;

@end
