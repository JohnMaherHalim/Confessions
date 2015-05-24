//
//  UserFormViewController.m
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "UserFormViewController.h"
#import "UsersController.h"

@interface UserFormViewController ()

@end

@implementation UserFormViewController

@synthesize Name , Address , Email , SocialName , Phone , datepicker , mynewuser,globaldate,ProfilePicture,globalimage,Confessor ,AddorSaveUserBtn, withinview ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Add New" ;
		mynewuser = [[User alloc]init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor clearColor]];
	[withinview setBackgroundColor:[UIColor clearColor]];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(dismissKeyboard)];
	
	[self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ChooseBirthdate:(id)sender {
	NSLog(@"%@" , datepicker.date);
	//mynewuser.User_BirthDate = datepicker.date ;
	globaldate = datepicker.date ;

	
}


-(void)viewWillAppear:(BOOL)animated {
	if (!DidCloseImagePicker) {
		globaldate = nil ;
		if (Confessor) {
			[AddorSaveUserBtn setTitle:@"Update data" forState:UIControlStateNormal];
			[Name setText:Confessor.User_Name];
			[Phone setText:Confessor.User_Phone];
			[Email setText:Confessor.User_Email];
			[Address setText:Confessor.User_Address];
			[datepicker setDate:Confessor.User_BirthDate];
			globaldate = Confessor.User_BirthDate ;
			if(Confessor.User_image)
				[ProfilePicture setImage:Confessor.User_image];
			globalimage = Confessor.User_image ;
		}
		else {
			[Name setText:@""];
			[Phone setText:@""];
			[Email setText:@""];
			[Address setText:@""];
			[datepicker setDate:[NSDate date]];
		
		}
	}
}

-(IBAction)FromPhotoGallery:(id)sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	
	// Don't forget to add UIImagePickerControllerDelegate in your .h
	picker.delegate = self;
	
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
	[self presentModalViewController:picker animated:YES];
}

-(IBAction)FromCamera:(id)sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	
	// Don't forget to add UIImagePickerControllerDelegate in your .h
	picker.delegate = self;
	
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	
	[self presentModalViewController:picker animated:YES];
}

-(IBAction)AddUser:(id)sender{
	BOOL flag = [self validatefields];
	
	
	if (flag) {
		if (Confessor) {
			for (User * curUser in [[UsersController sharedInstance]AllUsers]) {
				if ([curUser.User_Email isEqualToString:Confessor.User_Email] && [curUser.User_Phone isEqualToString:Confessor.User_Phone]) {
					curUser.User_Name = Name.text ;
					curUser.User_Address = Address.text ;
					curUser.User_Email = Email.text;
					//mynewuser.User_SocialMediaName = SocialName.text ;
					curUser.User_Phone = Phone.text ;
					curUser.User_BirthDate = globaldate ;
					curUser.User_image = globalimage ;
				}
			}
			
			[[UsersController sharedInstance]SaveConfessors] ;
			[self.navigationController popViewControllerAnimated:YES];
		} else {


			mynewuser = [[User alloc]init];
			mynewuser.User_Confessions = [[NSMutableArray alloc]init];
			mynewuser.User_Name = Name.text ;
			mynewuser.User_Address = Address.text ;
			mynewuser.User_Email = Email.text;
			//mynewuser.User_SocialMediaName = SocialName.text ;
			mynewuser.User_Phone = Phone.text ;
			mynewuser.User_CreationDate = [NSDate date];
			mynewuser.User_BirthDate = globaldate ;
			mynewuser.User_image = globalimage ;
			
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
			[mynewuser.User_Confessions addObject:newDate];
			
			
			[[UsersController sharedInstance]SetAlarmDate:newDate withName:mynewuser];
			
			[[[UsersController sharedInstance]AllUsers]addObject:mynewuser];
			
			[[UsersController sharedInstance]SaveConfessors];
			
			[self.tabBarController setSelectedIndex:3];
		}
	} else {
		UIAlertView *msg = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Fill all the data and choose birthdate please" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[msg show];
	}
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[self dismissModalViewControllerAnimated:YES];
	DidCloseImagePicker = true ;
	UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
	globalimage = image ;
	[ProfilePicture setImage:image];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //Iterate through your subviews, or some other custom array of views
    for (UIView *view in self.view.subviews)
        [view resignFirstResponder];
}

-(IBAction)TestAlarm:(id)sender{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	int daystocount = [prefs integerForKey:@"alarmrate"];
	if (!daystocount)
		daystocount = 2;
	NSDate *today = [NSDate date];
	NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
	//[dateComponents setDay:daystocount];
	[dateComponents setMinute:daystocount];
	
	// Retrieve date with increased days count
	NSDate *newDate = [[NSCalendar currentCalendar]
					   dateByAddingComponents:dateComponents
					   toDate:today options:0];
	
}


-(BOOL)validatefields {
	if (![Name.text length] || ![Phone.text length] || ![Email.text length])
		return false ;
	
	if (!globaldate)
		return false ;
	
	return true ;
}

-(void)dismissKeyboard {
	[self.view endEditing:YES]; 
}



@end
