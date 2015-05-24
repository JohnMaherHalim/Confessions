//
//  AppDelegate.m
//  Confessions
//
//  Created by John Maher on 12/19/14.
//  Copyright (c) 2014 John Maher. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "UserFormViewController.h"
#import "SettingsViewController.h"
#import "SearchViewController.h"
#import "UsersController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
	if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
		[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
	}
	
	[[UsersController sharedInstance]loadConfessors];
	
	SearchViewController *home = [[SearchViewController alloc]init];
	[home setType:1];
	UINavigationController *homenav = [[UINavigationController alloc]initWithRootViewController:home];
	/*UITabBarItem *tabtrial = [[UITabBarItem alloc]initWithTitle:@"Today" image:[UIImage imageNamed:@"tab_icon_today_50.png"] selectedImage:[UIImage imageNamed:@"tab_icon_today_50.png"]];
	[homenav setTabBarItem:tabtrial];*/
	UIImage *normaltoday = [UIImage imageNamed:@"tab_icon_today_50.png"];
	UIImage *selectedtoday = [UIImage imageNamed:@"tab_icon_today_50_selected.png"];
	normaltoday = [normaltoday imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	selectedtoday = [selectedtoday imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[homenav.tabBarItem setFinishedSelectedImage:selectedtoday withFinishedUnselectedImage:normaltoday];
	UserFormViewController *userform = [[UserFormViewController alloc]init] ;
	UINavigationController *userformnav = [[UINavigationController alloc]initWithRootViewController:userform];
	UIImage *normaladdone = [UIImage imageNamed:@"tab_icon_add_person_50.png"];
	UIImage *selectedaddone = [UIImage imageNamed:@"tab_icon_add_person_50_selected.png"];
	normaladdone = [normaladdone imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	selectedaddone = [selectedaddone imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[userformnav.tabBarItem setFinishedSelectedImage:selectedaddone withFinishedUnselectedImage:normaladdone];
	SettingsViewController *settings = [[SettingsViewController alloc]init] ;
	UINavigationController *settingsnav = [[UINavigationController alloc]initWithRootViewController:settings] ;
	UIImage *normalsettings = [UIImage imageNamed:@"tab_icon_settings_50.png"];
	UIImage *selectedsettings = [UIImage imageNamed:@"tab_icon_settings_50_selected.png"];
	normalsettings = [normalsettings imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	selectedsettings = [selectedsettings imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[settingsnav.tabBarItem setFinishedSelectedImage:selectedsettings withFinishedUnselectedImage:normalsettings];
	SearchViewController *search = [[SearchViewController alloc]init] ;
	[search setType:2];
	UINavigationController *searchnav = [[UINavigationController alloc]initWithRootViewController:search];
	UIImage *normalsearch = [UIImage imageNamed:@"tab_icon_search_50.png"];
	UIImage *selectedsearch = [UIImage imageNamed:@"tab_icon_search_50_selected.png"];
	normalsearch = [normalsearch imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	selectedsearch = [selectedsearch imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[searchnav.tabBarItem setFinishedSelectedImage:selectedsearch withFinishedUnselectedImage:normalsearch];
	
	UITabBarController *hometab = [[UITabBarController alloc]init] ;
	[hometab setViewControllers:[NSArray arrayWithObjects:homenav , userformnav , settingsnav , searchnav , nil]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	[self.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    //self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = hometab ;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
	UIAlertView *msg = [[UIAlertView alloc]initWithTitle:@"Alarm" message:notification.alertBody delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
	[msg show]; 
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
