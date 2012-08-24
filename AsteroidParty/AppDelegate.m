//
//  AppDelegate.m
//  AsteroidParty
//
//  Created by Rose CW on 8/23/12.
//  Copyright (c) 2012 Rose CW. All rights reserved.
//

#import "AppDelegate.h"
#import "AsteroidsView.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    
    self.window.rootViewController = [UIViewController new];
    self.window.rootViewController.view = [[AsteroidsView alloc] initWithFrame:self.window.bounds];
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
