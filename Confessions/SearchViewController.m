//
//  SearchViewController.m
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "SearchViewController.h"
#import "User.h"
#import "UsersController.h"
#import "ConfessorCell.h"
#import "UserDetailsViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize tableView , type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Search";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	
	AllUsers = [[[UsersController sharedInstance]AllUsers]mutableCopy];
	
	titles = [[NSMutableArray alloc]init] ;
	[titles addObject:@"Up to 12"];
	[titles addObject:@"13 - 18"];
	[titles addObject:@"19 - 39"];
	[titles addObject:@"40 to above"];
	
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	if (type == 1)
		self.title = @"Home" ;
	else
		self.title = @"Search";
	
	if (type == 1) {
		AllCategories = [[UsersController sharedInstance]FilterConfessorsbydate];
	} else {
		AllCategories = [[UsersController sharedInstance]FilterConfessorsbyAge];
	}
	[tableView reloadData] ;
}

- (void)filterContentForSearchText:(NSString*)searchText
{
	NSMutableArray *Users1 = [AllCategories objectForKey:@"cat1"];
	NSMutableArray *Users2 = [AllCategories objectForKey:@"cat2"];
	NSMutableArray *Users3 = [AllCategories objectForKey:@"cat3"];
	NSMutableArray *Users4 = [AllCategories objectForKey:@"cat4"];
	
	SearchResults1 = [self filterwithtext:searchText fromArray:Users1];
	SearchResults2 = [self filterwithtext:searchText fromArray:Users2];
	SearchResults3 = [self filterwithtext:searchText fromArray:Users3];
	SearchResults4 = [self filterwithtext:searchText fromArray:Users4];
	
	[AllCategories setObject:SearchResults1 forKey:@"cat1"];
	[AllCategories setObject:SearchResults2 forKey:@"cat2"];
	[AllCategories setObject:SearchResults3 forKey:@"cat3"];
	[AllCategories setObject:SearchResults4 forKey:@"cat4"];
	
	if (searchText.length == 0) {
		if (type == 1) {
			AllCategories = [[UsersController sharedInstance]FilterConfessorsbydate];
		} else {
			AllCategories = [[UsersController sharedInstance]FilterConfessorsbyAge];
		}
	}
	
	[tableView reloadData];
	
}


-(NSMutableArray*)filterwithtext:(NSString*)text fromArray:(NSMutableArray*)array {
	NSMutableArray *result = [[NSMutableArray alloc]init];
	
	for (User *curUser in array) {
		NSRange isRange = [curUser.User_Name rangeOfString:text options:NSCaseInsensitiveSearch];
		if(isRange.location == 0) {
			[result addObject:curUser];
			//found it...
		}
	}
	
	return result;
	
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[self filterContentForSearchText:searchText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[AllCategories allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[AllCategories allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AllCategories valueForKey:[[[AllCategories allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
   // return [[AllCategories allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	return titles ;
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
	
    User *book = [[AllCategories valueForKey:[[[AllCategories allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
    cell.textLabel.text = book.User_Name ;
	
    return cell;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//static NSString *simpleTableIdentifier = @"ConfessorCell";
	NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row];
	User *book = [[AllCategories valueForKey:[[[AllCategories allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
	ConfessorCell *cell = (ConfessorCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ConfessorCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
	
	/*cell.nameLabel.text = [tableData objectAtIndex:indexPath.row];
	cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
	cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];*/
	
	cell.ConfessorName.text = book.User_Name ;
	if (book.User_image)
		[cell.ConfessorPhoto setImage:book.User_image];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	User *book = [[AllCategories valueForKey:[[[AllCategories allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
	UserDetailsViewController *details = [[UserDetailsViewController alloc]init];
	[details setConfessor:book]; 
	[self.navigationController pushViewController:details animated:YES];
}

-(UIView*)GenerateViewWithName:(NSString*)sectionName andImageName:(NSString*)ImageName {
	
	UIView *resultview = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 100)] ;
	
	UIImage *img = [UIImage imageNamed:ImageName];
	
	UIImageView *sectionimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60, 10, 50, 50)];
	[sectionimage setImage:img];
	
	UILabel *sectiontitle = [[UILabel alloc]initWithFrame:CGRectMake(sectionimage.frame.origin.x + 70, 10, 300, 40)];
	[sectiontitle setText:sectionName];
	sectiontitle.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
	
	
	[resultview addSubview:sectionimage];
	[resultview addSubview:sectiontitle];
	
	
	return  resultview ;
	
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	
	UIView *resultview = [[UIView alloc]init] ;
	
	if (section == 0)
		resultview = [self GenerateViewWithName:@"Up to 12" andImageName:@"icons_512_kids.png"];
	else if (section == 1)
		resultview = [self GenerateViewWithName:@"13 - 18" andImageName:@"icons_512_youth.png"];
	else if (section == 2)
		resultview = [self GenerateViewWithName:@"19 - 39" andImageName:@"icons_512_old_people.png"];
	else
		resultview = [self GenerateViewWithName:@"40 to above" andImageName:@"icons_512_elder.png"];
	
	return resultview ;
	
	/*UIImage *myImage = [UIImage imageNamed:@"loginHeader.png"];
	UIImageView *imageView = [[[UIImageView alloc] initWithImage:myImage] autorelease];
	imageView.frame = CGRectMake(10,10,300,100);
	
	return imageView;*/
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50;
}


@end
