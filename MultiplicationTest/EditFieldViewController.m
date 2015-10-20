//
//  EditFieldViewController.m
//  MultiplicationTest
//
//  Created by Paul McGuire on 18/01/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EditFieldViewController.h"


@interface EditFieldViewController (PrivateMethods)
- (void)saveField:(id)sender;
- (void)cancelField:(id)sender;
@end

@implementation EditFieldViewController

@synthesize user;
@synthesize textField;
@synthesize saveButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.saveButton = [[[UIBarButtonItem alloc]
		initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
		target:self 
		action:@selector(saveField:)] autorelease];
	
	self.navigationItem.rightBarButtonItem = saveButton;
	
	UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
		initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
		target:self
		action:@selector(cancelField:)] autorelease];
	
	self.navigationItem.leftBarButtonItem = cancelButton;	
	self.navigationItem.title = @"Users Name";
	
	[textField addTarget:self action:@selector(onTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf {
	if (tf.text.length > 0) {
		[self saveField: tf];
		return YES;
	}
	return NO;
}

- (IBAction)dismissEdit {
	if (textField.text.length > 0) {
		[self saveField: textField];
	}
}

- (void)onTextFieldChanged: (id)sender {
	BOOL enableSave = textField.text.length > 0;
	saveButton.enabled = enableSave;
}

- (void)viewWillAppear:(BOOL)animated {
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	textField.enabled = YES;
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.text = user.name;
	[textField becomeFirstResponder];
}

- (void)saveField: (id)sender {
	user.name = textField.text;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelField: (id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
	[saveButton release];
}


@end
