//
//  UserFormViewController.h
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface UserFormViewController : UIViewController <UIImagePickerControllerDelegate> {
	BOOL DidCloseImagePicker ; 
}

@property (retain) User *mynewuser ;
@property (retain) NSDate *globaldate ;
@property (retain) UIImage *globalimage ; 
@property (retain) IBOutlet UITextField *Name ;
@property (retain) IBOutlet UITextField *Address ;
@property (retain) IBOutlet UITextField *Phone ;
@property (retain) IBOutlet UITextField *Email ; 
@property (retain) IBOutlet UITextField *SocialName ;
@property (retain) IBOutlet UIDatePicker *datepicker ;
@property (retain) IBOutlet UIImageView *ProfilePicture ;
@property (retain) User *Confessor ;
@property (retain) IBOutlet UIButton *AddorSaveUserBtn ; 
@property (retain) IBOutlet UIView *withinview ; 

-(IBAction)ChooseBirthdate:(id)sender;
-(IBAction)AddUser:(id)sender;
-(IBAction)FromPhotoGallery:(id)sender;
-(IBAction)FromCamera:(id)sender;
-(IBAction)Capture:(id)sender;
-(IBAction)TestAlarm:(id)sender;


@end
