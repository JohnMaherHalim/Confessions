//
//  SettingsViewController.h
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UIActionSheetDelegate>  {
	NSArray *stndrdbtns ;
	NSArray *delaybtns ; 
}

@property (retain) IBOutlet UIButton *stndrdbtn ;
@property (retain) IBOutlet UIButton *delaybtn ;

@property (retain) UIActionSheet *stndrdsheet ;
@property (retain) UIActionSheet *delaysheet; 

-(IBAction)ShowStandard:(id)sender;
-(IBAction)ShowDelay:(id)sender;
-(IBAction)Export:(id)sender;
-(IBAction)Import:(id)sender ;

@end
