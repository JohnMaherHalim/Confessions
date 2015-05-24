//
//  UserHistoryViewController.h
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
	NSMutableArray *ListOfConfessions ;
}

@property (retain) User *Confessor ;
@property (retain) IBOutlet UITableView *tableView;

-(IBAction)confessedtoday:(id)sender;

@end
