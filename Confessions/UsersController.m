//
//  UsersController.m
//  Confessions
//
//  Created by John Maher on 12/22/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "UsersController.h"
#import "User.h"

@implementation UsersController

@synthesize AllUsers ;

- (id)init	{
	
	if (self = [super init])	{
		//_Featuredprog = [[Program alloc]init];
		AllUsers = [[NSMutableArray alloc]init];
	}
	return self;
}

- (NSString *)getChacheDirectoryPath	{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

- (BOOL)SaveConfessors	{
	
	NSString *cacheDirectory 	= [self getChacheDirectoryPath];
	NSString *ConfessorsFile		= [cacheDirectory stringByAppendingPathComponent:@"Confessors.dat"];
	return [NSKeyedArchiver archiveRootObject:AllUsers toFile:ConfessorsFile];
}

- (BOOL)loadConfessors	{
	
	//	Cache
	
	NSString *cacheDirectory	= [self getChacheDirectoryPath];
	NSString *ConfessorsFile		= [cacheDirectory stringByAppendingPathComponent:@"Confessors.dat"];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:ConfessorsFile])
		AllUsers = [[NSKeyedUnarchiver unarchiveObjectWithFile:ConfessorsFile] mutableCopy];
	
	
	return ([AllUsers count] != 0);
}

+ (UsersController *)sharedInstance {
	static UsersController *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

-(NSMutableDictionary*)FilterConfessorsbyAge {
	NSMutableDictionary *result = [[NSMutableDictionary alloc]init] ;
	
	NSMutableArray *cat1 = [[NSMutableArray alloc]init] ;
	NSMutableArray *cat2 = [[NSMutableArray alloc]init] ;
	NSMutableArray *cat3 = [[NSMutableArray alloc]init] ;
	
	NSMutableArray *cat4 = [[NSMutableArray alloc]init];
	NSDate *today = [NSDate date];
	for (User *curUser in AllUsers) {
		
		NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
										   components:NSYearCalendarUnit
										   fromDate:curUser.User_BirthDate
										   toDate:today
										   options:0];
		
		if (ageComponents.year <= 12) {
			[cat1 addObject:curUser];
		} else if (ageComponents.year >= 13 && ageComponents.year < 19) {
			[cat2 addObject:curUser];
		} else if (ageComponents.year >= 19 && ageComponents.year < 39) {
			[cat3 addObject:curUser];
		} else if (ageComponents.year >= 40) {
			[cat4 addObject:curUser];
		}
		
	}
	
 	[result setObject:cat1 forKey:@"cat1"];
	[result setObject:cat2 forKey:@"cat2"];
	[result setObject:cat3 forKey:@"cat3"];
	[result setObject:cat4 forKey:@"cat4"];
	
	return result ;
}

-(NSMutableDictionary*)FilterConfessorsbydate {
	NSMutableDictionary *result = [[NSMutableDictionary alloc]init] ;
	
	NSMutableArray *FilteredUsers = [[NSMutableArray alloc]init];
	
	for (User *myuser in AllUsers) {
		int confessionscount = [myuser.User_Confessions count];
		if (confessionscount > 0) {
			NSDate *lastdate = [myuser.User_Confessions objectAtIndex:confessionscount-1];
			NSDate *today = [NSDate date];
			switch ([lastdate compare:today]) {
				case NSOrderedAscending:
					[FilteredUsers addObject:myuser];
					// dateOne is earlier in time than dateTwo
					break;
				case NSOrderedSame:
					[FilteredUsers addObject:myuser];
					// The dates are the same
					break;
				case NSOrderedDescending:
					// dateOne is later in time than dateTwo
					break;
			}
		}
	}
	
	NSMutableArray *cat1 = [[NSMutableArray alloc]init] ;
	NSMutableArray *cat2 = [[NSMutableArray alloc]init] ;
	NSMutableArray *cat3 = [[NSMutableArray alloc]init] ;
	
	NSMutableArray *cat4 = [[NSMutableArray alloc]init];
	NSDate *today = [NSDate date];
	for (User *curUser in FilteredUsers) {
		
		NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
										   components:NSYearCalendarUnit
										   fromDate:curUser.User_BirthDate
										   toDate:today
										   options:0];
		
		if (ageComponents.year < 12) {
			[cat1 addObject:curUser];
		} else if (ageComponents.year >= 13 && ageComponents.year < 19) {
			[cat2 addObject:curUser];
		} else if (ageComponents.year >= 19 && ageComponents.year < 39) {
			[cat3 addObject:curUser];
		} else if (ageComponents.year >= 40) {
			[cat4 addObject:curUser];
		}
		
	}
	
	[result setObject:cat1 forKey:@"cat1"];
	[result setObject:cat2 forKey:@"cat2"];
	[result setObject:cat3 forKey:@"cat3"];
	[result setObject:cat4 forKey:@"cat4"];
	
	return result ;
}

-(void)SetAlarmDate:(NSDate*)date withName:(User*)user  {
	UILocalNotification *notif = [[UILocalNotification alloc]init];
	notif.fireDate = date ;
	//notif.timeZone = [NSTimeZone defaultTimeZone];
	notif.alertBody = [NSString stringWithFormat:@"%@ has a confession today",user.User_Name];
	//notif.alertBody = @"test";
	notif.alertAction = @"Open!";
	notif.soundName = UILocalNotificationDefaultSoundName;
	//NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.name forKey:kTimerNameKey];
	NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
	[userInfo setObject:user.User_Phone forKey:@"UserPhone"];
	[userInfo setObject:user.User_Email forKey:@"UserMail"];
	notif.userInfo = userInfo;
	[[UIApplication sharedApplication] scheduleLocalNotification:notif];
}

-(void)CancelAlarmforUser:(User*)user {
	for (UILocalNotification *notification in [[[UIApplication sharedApplication] scheduledLocalNotifications] copy]){
		NSDictionary *userInfo = notification.userInfo;
		if ([user.User_Phone isEqualToString:[userInfo objectForKey:@"UserPhone"]] && [user.User_Email isEqualToString:[userInfo objectForKey:@"UserMail"]]){
			[[UIApplication sharedApplication] cancelLocalNotification:notification];
		}
	}
}

-(NSDate*)preparenewdatefromdate:(NSDate*)initialdate {
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
					   toDate:initialdate options:0];
	
	return newDate ; 
}

-(void)BackwardSetAlarms {
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
	NSMutableArray *FilteredUsers = [[NSMutableArray alloc]init];
	
	for (User *myuser in AllUsers) {
		int confessionscount = [myuser.User_Confessions count];
		if (confessionscount > 0) {
			NSDate *lastdate = [myuser.User_Confessions objectAtIndex:confessionscount-1];
			NSDate *today = [NSDate date];
			switch ([lastdate compare:today]) {
				case NSOrderedAscending:
					// dateOne is earlier in time than dateTwo
					break;
				case NSOrderedSame:
					// The dates are the same
					break;
				case NSOrderedDescending:
					[FilteredUsers addObject:myuser];
					// dateOne is later in time than dateTwo
					break;
			}
		}
	}
	
	
	for (User *curuser in FilteredUsers) {
		int count = curuser.User_Confessions.count ;
		if (count > 0) {
			NSDate *initialdate = [[NSDate alloc]init];
			if (count > 1){
				NSDate *beforelastdateset = [curuser.User_Confessions objectAtIndex:count-2];
				initialdate = beforelastdateset;
			} else {
				initialdate = curuser.User_CreationDate ;
			}
			NSDate *newdate = [self preparenewdatefromdate:initialdate];
			[self SetAlarmDate:newdate withName:curuser];
			[curuser.User_Confessions removeObjectAtIndex:count-1];
			[curuser.User_Confessions addObject:newdate];
		}
		
		
	}
	
	[self SaveConfessors];
	
}


-(void)deleteUser:(User*)user {
	int i = 0 ;
	BOOL flag = false ;
	int xcount = 0 ;
	for (User * curUser in AllUsers) {
		if ([curUser.User_Email isEqualToString:user.User_Email] && [curUser.User_Phone isEqualToString:user.User_Phone]) {
			//[AllUsers removeObjectAtIndex:i];
			flag = true ;
			xcount = i ;
		}
		i++ ;
	}
	
	if (flag)
		[AllUsers removeObjectAtIndex:xcount];
	
	[self SaveConfessors];
}




@end
