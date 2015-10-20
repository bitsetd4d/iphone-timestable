//
//  RootViewController.h
//  MultiplicationTest
//
//  Created by Paul McGuire on 28/12/2008.
//  Copyright D3BUG Software Ltd 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class FlipsideViewController;

@interface RootViewController : UIViewController {

    UIButton *infoButton;
    MainViewController *mainViewController;
    FlipsideViewController *flipsideViewController;
    UINavigationBar *flipsideNavigationBar;
}

@property (nonatomic, retain) IBOutlet UIButton *infoButton;
@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) UINavigationBar *flipsideNavigationBar;
@property (nonatomic, retain) FlipsideViewController *flipsideViewController;

- (IBAction)toggleView;

@end
