//
//  UserDetailsViewController.m
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "UserHistoryViewController.h"
#import "UserNotesViewController.h"
#import "UsersController.h"
#import "UserFormViewController.h"

@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController

@synthesize Confessor ; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"User Details" ; 
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)gotohistory:(id)sender {
	UserHistoryViewController *history = [[UserHistoryViewController alloc]init];
	[history setConfessor:Confessor];
	[self.navigationController pushViewController:history animated:YES];
}
-(IBAction)gotonotes:(id)sender {
	UserNotesViewController *notes = [[UserNotesViewController alloc]init];
	[notes setConfessor:Confessor];
	[self.navigationController pushViewController:notes animated:YES];
}

-(IBAction)DeleteMe:(id)sender {
	
	UIAlertView *msg = [[UIAlertView alloc]initWithTitle:@"Delete Confessor?" message:@"Are you sure you want to delete this confessor" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
	[msg show] ; 
	
}

-(IBAction)EditMe:(id)sender {
	UserFormViewController *userform = [[UserFormViewController alloc]init];
	[userform setConfessor:Confessor];
	[self.navigationController pushViewController:userform animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[[UsersController sharedInstance]deleteUser:Confessor];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end
