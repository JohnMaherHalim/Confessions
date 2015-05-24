//
//  UserHistoryViewController.m
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "UserHistoryViewController.h"
#import "UsersController.h"

@interface UserHistoryViewController ()

@end

@implementation UserHistoryViewController

@synthesize Confessor,tableView ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"History";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
	ListOfConfessions = Confessor.User_Confessions;
	[tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [ListOfConfessions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
 static NSString *CellIdentifier = @"Cell";
	
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
 }
	
 NSDate *book = [ListOfConfessions objectAtIndex:indexPath.row];
	NSString *dateString = [NSDateFormatter localizedStringFromDate:book
														  dateStyle:NSDateFormatterFullStyle
														  timeStyle:NSDateFormatterShortStyle];
	NSLog(@"%@",dateString);
	
 cell.textLabel.text = dateString ;
	
 return cell;
 }

-(IBAction)confessedtoday:(id)sender {
	int count = Confessor.User_Confessions.count ;
	if (Confessor.User_Confessions.count > 0) {
		NSDate *today = [NSDate date];
		NSDate *newalarmdate = [[UsersController sharedInstance]preparenewdatefromdate:today];
		[[UsersController sharedInstance]CancelAlarmforUser:Confessor];
		[[UsersController sharedInstance]SetAlarmDate:newalarmdate withName:Confessor];
		[Confessor.User_Confessions removeObjectAtIndex:count-1];
		[Confessor.User_Confessions addObject:today];
		[Confessor.User_Confessions addObject:newalarmdate];
		[[UsersController sharedInstance]SaveConfessors];
		[tableView reloadData];
		
	}
}



@end
