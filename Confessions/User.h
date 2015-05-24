//
//  User.h
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (retain) NSString *User_Name ;
@property (retain) NSString *User_History ;
@property (retain) NSString *User_Phone ;
@property (retain) NSString *User_Address ;
@property (retain) NSString *User_Email ;
@property (retain) NSString *User_SocialMediaName ; 
@property (retain) NSDate *User_BirthDate ;
@property (retain) NSDate *User_CreationDate; 
@property (retain) NSMutableArray *User_Confessions ;
@property (retain) UIImage *User_image; 

@end
