//
//  ChangeUserController.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ChangeUserController.h"
#import "MyControllerLoader.h"
#import "MultUser.h"

@implementation ChangeUserController

@synthesize editUserController;
@synthesize tableView;
@synthesize userList;

// TODO Case where use deletes current user

- (void)viewDidLoad {
	UIBarButtonItem *addItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUser:)] autorelease];
	
	self.navigationItem.rightBarButtonItem = addItem; //self.editButtonItem;
	self.navigationItem.title = @"Users";
	self.navigationItem.prompt = @"Choose or add user";
	
	//toolbar.items = [NSArray arrayWithObject: addItem];
	tableView.allowsSelectionDuringEditing = YES;
}

- (IBAction)addUser:(id)sender {
	if (editUserController == nil) {
		self.editUserController = [MyControllerLoader allocEditUserController];
	}
	editUserController.editingUser = [[[MultUser alloc] initWithDefaultValues] autorelease];
	editUserController.editing = NO;
	UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:editUserController];
	[self.navigationController presentModalViewController:navControl animated:YES];
	[navControl release];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.navigationItem setHidesBackButton:editing animated:animated];
    [tableView reloadData];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    // Show the disclosure indicator if editing.
	if (self.editing) return UITableViewCellAccessoryDisclosureIndicator;
	NSInteger myRow = indexPath.row;
	MultUser *u = [userList objectAtIndex: myRow];
	if (u.primaryKey == [MultUser currentUser].primaryKey) {
		return UITableViewCellAccessoryCheckmark;
	} 
	return UITableViewCellAccessoryNone;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear: animated];
	self.userList = [MultUser allUsers]; 
	[tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return userList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";	
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame: CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		cell.font = [UIFont systemFontOfSize:18];
	}
	NSInteger myRow = indexPath.row;
	MultUser *u = [userList objectAtIndex: myRow];
	cell.text = [u name];
	cell.image = [u miniImage];
	cell.textColor = [UIColor blackColor];
	return cell;	
}


- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MultUser *user = [userList objectAtIndex:indexPath.row];
	[MultUser currentUser: user];
	[myTableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.navigationController popViewControllerAnimated:YES];
	[self.navigationController.topViewController viewDidAppear:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[editUserController release];
	[tableView release];
    [super dealloc];
}


@end
