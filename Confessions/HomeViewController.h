//
//  HomeViewController.h
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h" 

@interface HomeViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>

@property (retain) NSMutableArray *TodayUsers ;
@property (retain) UITableView *tableView ; 


@end
