//
//  AppDelegate.m
//  startMemory
//
//  Created by Artist on 2/24/16.
//  Copyright © 2016 ever8greener. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    self.window = [[UIWindow alloc]  initWithFrame:[[UIScreen mainScreen]bounds]];
    RootViewController *vc = [[RootViewController alloc]initWithNibName:@"RootViewController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    return YES;
    
    
}

@end
