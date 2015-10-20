//
//  AddUserController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultUser.h"

@interface AddUserController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate> {

//	UINavigationController *navigationController;
	UIImagePickerController *imagePickerController;
	UITextField *nameField;
	UIButton *testButton;
	UINavigationBar *navigationBar;
	
	MultUser *editingUser;
}

@property (nonatomic,retain) IBOutlet UINavigationBar *navigationBar;
//@property (nonatomic,retain) UINavigationController *navigationController; // DEFUNCT ?
@property (nonatomic,retain) IBOutlet UIButton *testButton;
@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) MultUser *editingUser;

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
		editingInfo:(NSDictionary *)editingInfo;

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;

- (IBAction)changePhoto;  // togo
- (IBAction)choosePhotoFromLibrary;  // togo
- (IBAction)takePhotoWithCamera;     // togo
- (IBAction)closeView;

@end
