//
//  SearchViewController.h
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDataSource , UITableViewDelegate,UISearchBarDelegate > {
	NSMutableArray *AllUsers ;
	NSArray *SearchResults1 ;
	NSArray *SearchResults2 ;
	NSArray *SearchResults3 ;
	NSArray *SearchResults4 ;
	NSMutableDictionary *AllCategories ;
	NSMutableArray *titles ;
}


@property int type ; 
@property (retain) IBOutlet UITableView *tableView ;



@end
