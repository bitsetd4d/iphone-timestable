//
//  AddUserController.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AddUserController.h"
#import "ImageUtilities.h"

@implementation AddUserController

//@synthesize navigationController;
@synthesize navigationBar;
@synthesize nameField;
@synthesize testButton;
@synthesize editingUser;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.editingUser = [[MultUser currentUser] copy];
	UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc]
									initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveUser:)] autorelease];
	self.navigationItem.rightBarButtonItem = saveButton;
	UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
									initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelUser:)] autorelease];
	self.navigationItem.leftBarButtonItem = cancelButton;	
	self.navigationItem.prompt = @"Change Name or Photo";
	
	[self.navigationBar pushNavigationItem: self.navigationItem animated:YES];
	
	nameField.text = editingUser.name;
	[testButton setBackgroundImage:editingUser.image forState: UIControlStateNormal];
	
}

- (IBAction)changePhoto {
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
								  initWithTitle: nil
								  delegate: self
								  cancelButtonTitle: @"Cancel"
								  destructiveButtonTitle: nil
								  otherButtonTitles: @"Take Photo", @"Choose Existing Photo", nil];
	[actionSheet showInView: self.view];	
}

- (void)saveUser: (id)sender {
	[MultUser saveUserAndMakeCurrent: editingUser];
	[self dismissModalViewControllerAnimated: YES];
	[self.navigationController popViewControllerAnimated: NO];
}

- (void)cancelUser: (id)sender {
	[self dismissModalViewControllerAnimated: YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	editingUser.name = theTextField.text;
	return YES;
}

- (IBAction)closeView {
	[self dismissModalViewControllerAnimated: YES];
	//[navigationController popViewControllerAnimated: NO];
	[self.navigationController popViewControllerAnimated: NO];
}

// – actionSheet:clickedButtonAtIndex:  optional method  
// actionSheetCancel:  optional method  

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		[self takePhotoWithCamera];
	} else if (buttonIndex == 1) {
		[self choosePhotoFromLibrary];
	}
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
	// Nothing to do
}

- (IBAction)choosePhotoFromLibrary {
	imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.allowsImageEditing = YES;
	[self presentModalViewController: imagePickerController animated: YES];
}

- (IBAction)takePhotoWithCamera {
	imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
	imagePickerController.allowsImageEditing = YES;
	[self presentModalViewController: imagePickerController animated: YES];	
}


- (void)imagePickerController:(UIImagePickerController*)picker
        didFinishPickingImage:(UIImage*)image
		editingInfo:(NSDictionary*)editingInfo {
	
	[self dismissModalViewControllerAnimated:YES];
	UIImage *resizedImage = [ImageUtilities resizedImage:image size:testButton.bounds];
	[testButton setBackgroundImage:resizedImage forState: UIControlStateNormal];
	editingUser.image = resizedImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[imagePickerController release];
    [super dealloc];
}


@end
