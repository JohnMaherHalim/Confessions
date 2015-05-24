//
//  SettingsViewController.m
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "SettingsViewController.h"
#import "UsersController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize stndrdsheet , delaybtn ,stndrdbtn , delaysheet ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Settings" ; 
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	int daystocount = [prefs integerForKey:@"alarmrate"];
	
	if (!daystocount || daystocount == 30) {
		[stndrdbtn setTitle:@"One month" forState:UIControlStateNormal];
	} else if (daystocount == 60) {
		[stndrdbtn setTitle:@"2 months" forState:UIControlStateNormal];
	} else if (daystocount == 90) {
		[stndrdbtn setTitle:@"3 months" forState:UIControlStateNormal];
	} else if (daystocount == 1) {
		[stndrdbtn setTitle:@"1 day" forState:UIControlStateNormal];
	}
		
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ShowStandard:(id)sender {
	stndrdbtns = [[NSArray alloc] initWithObjects:
                      [NSString stringWithString:@"One month"],
                      [NSString stringWithString:@"2 months"],
                      [NSString stringWithString:@"3 months"],
				  [NSString stringWithString:@"1 day"],
                      nil];
	
    stndrdsheet = [[UIActionSheet alloc] initWithTitle:@"Standard Reminder"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
	
    // ObjC Fast Enumeration
    for (NSString *title in stndrdbtns) {
        [stndrdsheet addButtonWithTitle:title];
    }
	
	
    [stndrdsheet showInView:self.view];
}

-(IBAction)ShowDelay:(id)sender {
	delaybtns = [[NSArray alloc] initWithObjects:
                      [NSString stringWithString:@"One day"],
                      [NSString stringWithString:@"3 days"],
                      [NSString stringWithString:@"One Week"],
                      nil];
	
    delaysheet = [[UIActionSheet alloc] initWithTitle:@"Delay Reminder"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
	
    // ObjC Fast Enumeration
    for (NSString *title in delaybtns) {
        [delaysheet addButtonWithTitle:title];
    }
	
	
    [delaysheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (actionSheet == stndrdsheet) {
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		if (buttonIndex == 0)
			[prefs setInteger:30 forKey:@"alarmrate"];
		else if (buttonIndex == 1)
			[prefs setInteger:60 forKey:@"alarmrate"];
		else if (buttonIndex == 2)
			[prefs setInteger:90 forKey:@"alarmrate"];
		else
			[prefs setInteger:1 forKey:@"alarmrate"];
		[prefs synchronize];
		[[UsersController sharedInstance]BackwardSetAlarms];
		[stndrdbtn setTitle:stndrdbtns[buttonIndex] forState:UIControlStateNormal];
		
	} else {
		[delaybtn setTitle:delaybtns[buttonIndex] forState:UIControlStateNormal];
	}
}

-(IBAction)Export:(id)sender {
	NSMutableString *csvstring = [[NSMutableString alloc]init];
	[csvstring appendString:@"UserName,Address,Phone,Mail,birthdate \n"];
	
	for (User *myuser in [[UsersController sharedInstance]AllUsers]) {
		NSString *dateString = [NSDateFormatter localizedStringFromDate:myuser.User_BirthDate
															  dateStyle:NSDateFormatterShortStyle
															  timeStyle:NSDateFormatterNoStyle];
		[csvstring appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@ \n",myuser.User_Name,myuser.User_Address,myuser.User_Phone,myuser.User_Email,dateString]];
		
	}
	
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *cacheDirectory 	= [paths objectAtIndex:0];
	NSString *ConfessorsFile		= [cacheDirectory stringByAppendingPathComponent:@"ConfessorsExported.csv"];
	
	NSLog(csvstring);
	NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
	
	NSError *error;
	
	[csvstring writeToFile:ConfessorsFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

-(IBAction)Import:(id)sender {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

	
	//	Cache
	
	NSString *cacheDirectory	= [paths objectAtIndex:0];
	NSString *ConfessorsFile		= [cacheDirectory stringByAppendingPathComponent:@"Confessors.csv"];
	
	
	
	NSError *error;
	NSString *csvFileString = [NSString stringWithContentsOfFile:ConfessorsFile encoding:NSUTF8StringEncoding error:&error];
	
	
	NSLog(csvFileString);
	if (csvFileString) {
	NSMutableArray * fileLines = [[NSMutableArray alloc] initWithArray:[csvFileString componentsSeparatedByString:@"\r"] copyItems: YES];
	NSString *strexample = fileLines[1];
	
	for (int i = 1 ; i < fileLines.count-1; i++) {
		NSString *strexample = fileLines[i];
		NSArray *items = [strexample componentsSeparatedByString:@","];
		
		BOOL isThere = [self checkInUsersFromData:items] ;
		
		if(!isThere) {
		User* myUser = [[User alloc]init];
		myUser.User_Confessions =[[NSMutableArray alloc]init];
		myUser.User_Name = items[0];
		myUser.User_Address = items[1];
		myUser.User_Phone = items[2];
		myUser.User_Email = items[4];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		// this is imporant - we set our input date format to match our input string
		// if format doesn't match you'll get nil from your string, so be careful
		[dateFormatter setDateFormat:@"MM/dd/yy"];
		NSDate *dateFromString = [[NSDate alloc] init];
		// voila!
			NSString *testdate = items[3] ;
		dateFromString = [dateFormatter dateFromString:items[3]];
		myUser.User_BirthDate = dateFromString;
			
			if (!dateFromString)
				myUser.User_BirthDate = [NSDate date];
			
			
		myUser.User_CreationDate = [NSDate date];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		int daystocount = [prefs integerForKey:@"alarmrate"];
		if (!daystocount)
			daystocount = 30;
		NSDate *today = [NSDate date];
		NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
		[dateComponents setDay:daystocount];
		//[dateComponents setMinute:daystocount];
		
		// Retrieve date with increased days count
		NSDate *newDate = [[NSCalendar currentCalendar]
						   dateByAddingComponents:dateComponents
						   toDate:today options:0];
		[myUser.User_Confessions addObject:newDate];
		
		
		[[UsersController sharedInstance]SetAlarmDate:newDate withName:myUser];
		
		[[[UsersController sharedInstance]AllUsers]addObject:myUser];
		
		[[UsersController sharedInstance]SaveConfessors];
		}
	}
	
	NSLog(strexample) ;
	} else {
		UIAlertView *msg = [[UIAlertView alloc]initWithTitle:@"File not found" message:@"It seems you didn't put any backup file to get your data" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[msg show] ;
	}
	
	
}


-(BOOL)checkInUsersFromData:(NSArray*)items {
	BOOL result = false ;
	
	NSString *Name = items[0];
	NSString *Phone = items[2];
	
	for (User *sub in [[UsersController sharedInstance]AllUsers]) {
		if ([sub.User_Name isEqualToString:Name] && [sub.User_Phone isEqualToString:Phone])
			result = true ;
	}
	
	
	return  result ;
}

@end
