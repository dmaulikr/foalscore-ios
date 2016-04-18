//
//  AppDelegate.m
//  foal score
//
//  Created by Jun on 1/23/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // start here
    // create tabbar controller
    UITabBarController *tabBars = [[UITabBarController alloc]init];
    tabBars.tabBar.tintColor = [UIColor colorWithRed:(90/255.0) green:(17/255.0) blue:(10/255.0) alpha:1];

    // create 2 main controllers on main page
    SurvivalScoreViewController *tab1 = [[SurvivalScoreViewController alloc]init];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [DataManager setFirst:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    SepsisScoreViewController *tab2 = [[SepsisScoreViewController alloc]init];
    // create UiNaviController for user info part
    UserInfoTableViewController *userInfor = [[UserInfoTableViewController alloc]init];
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:userInfor];
    nv.navigationBar.tintColor = [UIColor colorWithRed:(90/255.0) green:(17/255.0) blue:(10/255.0) alpha:1];
    // Add them into array
    NSMutableArray *localViewControllersArray = [[NSMutableArray alloc]initWithCapacity:3];
    [localViewControllersArray addObject:tab1];
    [localViewControllersArray addObject:tab2];
    [localViewControllersArray addObject:nv];
    // add icons
    //unselectedImage
    UIImage *tab_sur = [UIImage imageNamed:@"hearts.png"];
    UIImage *tab_spes =[UIImage imageNamed:@"foal.png"];
    UIImage *menu = [UIImage imageNamed:@"menu.png"];
    //selectedImage
   // UIImage *tab_sur1= [UIImage imageNamed:@"hearts1.png"];
   // UIImage *tab_spes1 =[UIImage imageNamed:@"foal1.png"];
    //UIImage *menu2 = [UIImage imageNamed:@"menu2.png"];
    //add
    tab1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Survival Score" image:tab_sur selectedImage:nil];
    tab2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Sepsis Score" image:tab_spes selectedImage:nil];
    nv.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Hub" image:menu selectedImage:nil];
    // lanch 3 pages on tabViewController
    tabBars.viewControllers = localViewControllersArray;
    tabBars.view.autoresizingMask = (UIViewAutoresizingFlexibleHeight);
    
    // add to window
    self.window.rootViewController = tabBars;
    
    [self.window makeKeyAndVisible];
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [DataManager saveChanges];
    if(success){
        NSLog(@"Saved");
    }else{
        NSLog(@"Unsuccessful");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    BOOL success = [DataManager saveChanges];
    if(success){
        NSLog(@"Saved");
    }else{
        NSLog(@"Unsuccessful");
    }
}

@end
