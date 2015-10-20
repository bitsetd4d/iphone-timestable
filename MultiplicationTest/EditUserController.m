//
//  EditUserController.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 15/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EditUserController.h"
#import "EditFieldViewController.h"
#import "ImageUtilities.h"

@interface EditUserController (PrivateMethods)
- (void)takePhotoWithCamera;
- (void)choosePhotoFromLibrary;
- (void)deleteUser;
@end

@implementation EditUserController

@synthesize tableView;
@synthesize headerView;
@synthesize editingUser;
@synthesize imageButton;

// TODO user changes picture or name, but presses cancel

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.autoresizesSubviews = YES;
	self.tableView.tableHeaderView = self.headerView;
	UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
									initWithTitle: @"Cancel" style: UIBarButtonItemStylePlain target:self action:@selector(cancelEdit:)] autorelease];
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc]
									initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editDone:)] autorelease];
	self.navigationItem.leftBarButtonItem = cancelButton;
	self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)viewWillAppear:(BOOL)animated {
	if (self.editing) {
		self.navigationItem.title = @"Change Details";
	} else {
		self.navigationItem.title = @"Add User";
	}
	[imageButton setBackgroundImage:editingUser.image forState: UIControlStateNormal];
	[tableView reloadData];
}

#pragma mark User actions

- (IBAction)changePhoto {
	askingAboutDelete = NO;
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
								  initWithTitle: nil
								  delegate: self
								  cancelButtonTitle: @"Cancel"
								  destructiveButtonTitle: nil
								  otherButtonTitles: @"Take Photo", @"Choose Existing Photo", nil];
	[actionSheet showInView: self.view];	
}

- (void)deleteUser {
	askingAboutDelete = YES;
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
								  initWithTitle: nil
								  delegate: self
								  cancelButtonTitle: @"Cancel"
								  destructiveButtonTitle: @"Delete this user!"
								  otherButtonTitles: nil];
	[actionSheet showInView: self.view];	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	[self dismissModalViewControllerAnimated: YES];
}

- (void)editDone: (id)sender {
	[MultUser saveUserAndMakeCurrent: editingUser];
	[self dismissModalViewControllerAnimated: YES];
}

- (void)cancelEdit: (id)sender {
	[self dismissModalViewControllerAnimated: YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (askingAboutDelete) {
		if (buttonIndex == actionSheet.destructiveButtonIndex) {
			[editingUser deleteFromDatabase];
			UIAlertView *alert = [[UIAlertView alloc] 
						initWithTitle:@"User deleted" 
						message:@"The user has been deleted!" 
						delegate:self
						cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
		return;
	} 
	if (buttonIndex == 0) {
		[self takePhotoWithCamera];
	} else if (buttonIndex == 1) {
		[self choosePhotoFromLibrary];
	}
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
	// Nothing to do
}

#pragma mark Choose Photo

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
	UIImage *resizedImage = [ImageUtilities resizedImage:image size:imageButton.bounds];
	[imageButton setBackgroundImage:resizedImage forState: UIControlStateNormal];
	editingUser.image = resizedImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
		if (cell == nil) {
			// Create a new cell. CGRectZero allows the cell to determine the appropriate size.
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"ButtonCell"] autorelease];
		}
		cell.textColor = [UIColor redColor];
		cell.font = [UIFont systemFontOfSize: 14];
		cell.text = @"Delete User";
		
		//cell.textAlignment = UITextAlignmentRight;
		// Workaround http://openradar.appspot.com/radar?id=654
		UILabel* label = (UILabel*)[[[cell contentView] subviews] objectAtIndex:0]; label.textAlignment = UITextAlignmentCenter;

		return cell;
	}
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FieldCell"];
    if (cell == nil) {
        // Create a new cell. CGRectZero allows the cell to determine the appropriate size.
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"FieldCell"] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	cell.text = editingUser.name; 
    return cell;
}


- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    // Return the displayed title for the specified section.
    switch (section) {
        case 0: return @"Name";
		case 1: return @"Delete";	
    }
    return nil;
}


- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	[tv deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.section == 1) {
		[self deleteUser];
		return;
	}
	EditFieldViewController *editFieldViewController = [[EditFieldViewController alloc] initWithNibName:@"EditField" bundle:nil];
	editFieldViewController.user = editingUser;
	[self.navigationController pushViewController:editFieldViewController animated:YES]; 
	[editFieldViewController release];
}


- (void)dealloc {
	[imagePickerController release];
    [super dealloc];
}


@end

