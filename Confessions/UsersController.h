//
//  UsersController.h
//  Confessions
//
//  Created by John Maher on 12/22/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UsersController : NSObject

@property (retain) NSMutableArray *AllUsers ;

+ (UsersController *)sharedInstance;

- (BOOL)SaveConfessors;
- (BOOL)loadConfessors;

-(NSMutableDictionary*)FilterConfessorsbyAge ;
-(void)SetAlarmDate:(NSDate*)date withName:(User*)user ;
-(void)CancelAlarmforUser:(User*)user ;
-(NSDate*)preparenewdatefromdate:(NSDate*)initialdate;
-(NSMutableDictionary*)FilterConfessorsbydate;
-(void)BackwardSetAlarms;
-(void)deleteUser:(User*)user ;

@end
