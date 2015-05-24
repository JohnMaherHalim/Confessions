//
//  User.m
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize User_Address , User_BirthDate , User_Confessions , User_Email, User_History , User_Name , User_Phone , User_SocialMediaName,User_image,User_CreationDate ;

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:User_Name forKey:@"User_Name"];
    [encoder encodeObject:User_Phone forKey:@"User_Phone"];
	[encoder encodeObject:User_Address forKey:@"User_Address"];
	[encoder encodeObject:User_BirthDate forKey:@"User_Birthdate"];
	[encoder encodeObject:User_Confessions forKey:@"User_Confessions"];
	[encoder encodeObject:User_Email forKey:@"User_Email"];
	[encoder encodeObject:User_History forKey:@"User_History"];
	[encoder encodeObject:User_SocialMediaName forKey:@"User_SocialMediaName"];
	[encoder encodeObject:User_image forKey:@"User_Image"];
	[encoder encodeObject:User_CreationDate forKey:@"User_CreationDate"];
	
}

- (id)initWithCoder:(NSCoder *)decoder {
    User_Name = [decoder decodeObjectForKey:@"User_Name"];
	 User_Phone = [decoder decodeObjectForKey:@"User_Phone"];
	 User_Address = [decoder decodeObjectForKey:@"User_Address"];
	 User_BirthDate = [decoder decodeObjectForKey:@"User_Birthdate"];
	 User_Confessions = [decoder decodeObjectForKey:@"User_Confessions"];
	 User_Email = [decoder decodeObjectForKey:@"User_Email"];
	 User_History = [decoder decodeObjectForKey:@"User_History"];
	 User_SocialMediaName = [decoder decodeObjectForKey:@"User_SocialMediaName"];
	User_image = [decoder decodeObjectForKey:@"User_Image"];
	User_CreationDate = [decoder decodeObjectForKey:@"User_CreationDate"];
    return self;
}


@end
