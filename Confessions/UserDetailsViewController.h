//
//  UserDetailsViewController.h
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserDetailsViewController : UIViewController <UIAlertViewDelegate>

@property (retain) User *Confessor ; 

-(IBAction)gotohistory:(id)sender;
-(IBAction)gotonotes:(id)sender;
-(IBAction)DeleteMe:(id)sender;
-(IBAction)EditMe:(id)sender;

@end
