//
//  UserNotesViewController.m
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "UserNotesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UsersController.h"

@interface UserNotesViewController ()

@end

@implementation UserNotesViewController

@synthesize Confessor , notes ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Notes" ;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	notes.layer.borderWidth = 2.0f;
	
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
	if (Confessor.User_History != nil)
		[notes setText:Confessor.User_History];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)SaveUserNotes:(id)sender {
	for (User * curUser in [[UsersController sharedInstance]AllUsers]) {
		if ([curUser.User_Email isEqualToString:Confessor.User_Email] && [curUser.User_Phone isEqualToString:Confessor.User_Phone]) {
			curUser.User_History = notes.text ;
		}
	}
	
	[[UsersController sharedInstance]SaveConfessors] ;
	[self.navigationController popViewControllerAnimated:YES];
}

@end
