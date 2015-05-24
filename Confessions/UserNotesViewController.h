//
//  UserNotesViewController.h
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserNotesViewController : UIViewController

@property (retain) User *Confessor;
@property (retain) IBOutlet UITextView *notes ;

-(IBAction)SaveUserNotes:(id)sender;

@end
